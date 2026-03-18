from ns9chatapi.api.serializers import RegistrationSerializer, LoginSerializer
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.request import Request
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.models import User
from typing import Dict, Any, Optional

class RegisterView(generics.CreateAPIView):
    serializer_class = RegistrationSerializer
    permission_classes = [AllowAny]
    
    def create(self, request: Request, *args, **kwargs) -> Response:
        serializer: RegistrationSerializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        user: User = serializer.save()
        
        refresh: RefreshToken = RefreshToken.for_user(user)
        
        response_data: Dict[str, Any] = {
            'user': {
                'id': user.id,
                'username': user.username,
                'email': user.email,
            },
            'tokens': {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            },
            'message': 'Пользователь успешно зарегистрирован'
        }
        
        return Response(response_data, status=status.HTTP_201_CREATED)

class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [AllowAny]
    
    def post(self, request: Request, *args, **kwargs) -> Response:
        serializer: LoginSerializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        data: Dict[str, Any] = serializer.validated_data
        user: User = data['user']
        
        response_data: Dict[str, Any] = {
            'user': {
                'id': user.id,
                'username': user.username,
                'email': user.email,
            },
            'tokens': {
                'refresh': data['refresh'],
                'access': data['access'],
            }
        }
        
        return Response(response_data, status=status.HTTP_200_OK)

class LogoutView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]
    
    def post(self, request: Request) -> Response:
        try:
            refresh_token: str = request.data.get('refresh')
            if not refresh_token:
                return Response(
                    {'error': 'Необходимо указать refresh токен'}, 
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            token: RefreshToken = RefreshToken(refresh_token)
            token.blacklist()
            
            return Response(
                {'message': 'Успешный выход из системы'}, 
                status=status.HTTP_205_RESET_CONTENT
            )
        except Exception as e:
            return Response(
                {'error': str(e)}, 
                status=status.HTTP_400_BAD_REQUEST
            )

class ProtectedView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request: Request) -> Response:
        user: User = request.user
        return Response({
            'message': f'Привет, {user.username}!',
            'data': 'Это защищенные данные'
        })