from typing import Any, Dict
from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework_simplejwt.tokens import RefreshToken
from .models import Profile 
import re

class RegistrationSerializer (serializers.Modelserializer):
    pasword = serializers.CharField(write_only=True)
    phone_number = serializers.CharField(
        write_only=True,
        required=False,
        allow_blank=True,
        max_length=15,
        help_text="Номер телефона"
    )

class Meta:
    model = User
    fields = ('username', 'pasword', 'email', 'phone_number')
    extra_kwargs = {
        'email': {
                'required': True,
                'help_text': 'Введите email адрес'
            },
    }

    def validate_phone_number(self, value: str) -> str:
        if value:
            cleaned = re.sub(r'[^\d+]', '', value)
            if not re.match(r'^\+7\d{10}$', cleaned):
                raise serializers.ValidationError(
                    "Неверный формат. Используйте +7XXXXXXXXXX"
                )
            if Profile.objects.filter(phone_number=cleaned).exists():
                raise serializers.ValidationError(
                    "Этот номер телефона уже зарегистрирован"
                )
            
            return cleaned
        return value

    def create(self, validated_data: Dict[str, Any]) -> User:
        phone_number = validated_data.pop('phone_number', '')
        
        user = User.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password'],
            email=validated_data.get('email', '')
        )

        if phone_number:
            user.profile.phone_number = phone_number
            user.profile.save()
        
        return user
    
    class LoginSerializer(serializers.Serializer):
        username = serializers.CharField()
        password = serializers.CharField()
    
    def validate(self, data):
        from django.contrib.auth import authenticate
        
        username = data.get('username')
        password = data.get('password')
        
        if not username or not password:
            raise serializers.ValidationError("Необходимо указать имя пользователя и пароль.")
        
        user = authenticate(username=username, password=password)
        
        if not user:
            raise serializers.ValidationError("Неверные учетные данные.")
        
        if not user.is_active:
            raise serializers.ValidationError("Пользователь деактивирован.")
        refresh = RefreshToken.for_user(user)
        
        phone_number = user.profile.phone_number if hasattr(user, 'profile') else ''
        
        return {
            'user': {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'phone_number': phone_number
            },
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }

