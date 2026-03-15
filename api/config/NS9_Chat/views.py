from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView

from NS9_Chat.serializers import RegisterSerializer, LoginSerializer

class RegisterView(generics.CreateAPIView):
    """ API представление для регистрации нового пользователя с JWT токенами. """
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]  # доступно всем

    def create(self, request, *args, **kwargs) -> Response:
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        
        # Получаем созданного пользователя
        user = serializer.instance
        
        # Генерируем JWT токены
        refresh = RefreshToken.for_user(user)
        
        return Response({
            'user': {
                'id': user.id,
                'username': user.username,
                'email': user.email
            },
            'refresh': str(refresh),
            'access': str(refresh.access_token),
            'message': 'Пользователь успешно создан'
        }, status=status.HTTP_201_CREATED, headers=headers)


class LoginView(APIView):
    """ API представление для входа пользователя с получением JWT токенов. """
    permission_classes = [AllowAny]
    
    def post(self, request, *args, **kwargs) -> Response:
        # Используем LoginSerializer для валидации
        serializer = LoginSerializer(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        
        # Получаем пользователя из validated_data
        user = serializer.validated_data['user']
        
        # Генерируем новые JWT токены
        refresh = RefreshToken.for_user(user)
        
        return Response({
            'user': {
                'id': user.id,
                'username': user.username,
                'email': user.email
            },
            'refresh': str(refresh),
            'access': str(refresh.access_token),
            'message': 'Вход выполнен успешно'
        }, status=status.HTTP_200_OK)


class ProtectedView(APIView):
    """ Защищенное представление, требующее валидного JWT токена. """
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs) -> Response:
        # request.user доступен благодаря JWTAuthentication
        user = request.user
        return Response({
            'message': f'Привет, {user.username}! Это защищенный JWT endpoint',
            'user_id': user.id,
            'email': user.email
        }, status=status.HTTP_200_OK)


# Дополнительное представление для обновления access токена
class RefreshTokenView(APIView):
    """ Представление для обновления access токена по refresh токену. """
    permission_classes = [AllowAny]
    
    def post(self, request, *args, **kwargs) -> Response:
        refresh_token = request.data.get('refresh')
        
        if not refresh_token:
            return Response(
                {'error': 'Необходимо указать refresh токен'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            refresh = RefreshToken(refresh_token)
            new_access_token = str(refresh.access_token)
            
            return Response({
                'access': new_access_token,
                'message': 'Токен успешно обновлен'
            }, status=status.HTTP_200_OK)
            
        except Exception as e:
            return Response(
                {'error': 'Недействительный refresh токен'}, 
                status=status.HTTP_400_BAD_REQUEST
            )


# Альтернативный вариант: использование встроенного TokenObtainPairView
class LoginTokenObtainPairView(TokenObtainPairView):
    """ Встроенное представление simplejwt для получения пары токенов. """
    # Можно переопределить сериализатор если нужно
    # serializer_class = MyTokenObtainPairSerializer
    permission_classes = [AllowAny]

# Create your views here.
