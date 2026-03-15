from django.urls import path
from NS9_Chat.views import (
    RegisterView, 
    LoginView, 
    ProtectedView,
    RefreshTokenView
)

urlpatterns = [
    
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('token/refresh/', RefreshTokenView.as_view(), name='token_refresh'),
    path('protected/', ProtectedView.as_view(), name='protected_resource'),
]