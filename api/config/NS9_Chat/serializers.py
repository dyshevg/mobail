from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework_simplejwt.tokens import RefreshToken


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('username', 'password', 'email')

    def create(self, validated_data: dict) -> User:
        user = User.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password'],
            email=validated_data.get('email', '')
        )
        return user

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data: dict) -> dict:
        from django.contrib.auth import authenticate

        username = data.get('username')
        password = data.get('password')

        if not username or not password:
            raise serializers.ValidationError("Необходимо указать имя пользователя и пароль.")

        user = authenticate(request=self.context.get('request'), username=username, password=password)

        if not user:
            raise serializers.ValidationError("Неверные учетные данные.")

        if not user.is_active:
            raise serializers.ValidationError("Пользователь деактивирован.")
        
        data['user'] = user
        return data