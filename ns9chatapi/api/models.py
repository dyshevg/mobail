# models.py (нужно создать новый файл или добавить в существующий)
from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class Profile(models.Model):
    """Профиль пользователя с дополнительными полями"""
    user = models.OneToOneField(
        User, 
        on_delete=models.CASCADE,
        related_name='profile'
    )
    phone_number = models.CharField(
        max_length=15,
        blank=True,
        verbose_name="Номер телефона"
    )
    
    def __str__(self):
        return f"Profile of {self.user.username}"
    
@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()