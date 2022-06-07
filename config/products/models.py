import uuid

from django.core.validators import MinValueValidator
from django.db import models
from django.utils.translation import gettext_lazy as _


class BaseModel(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)

    class Meta:
        abstract = True


class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class Category(BaseModel, TimeStampedModel):
    title = models.CharField(_('title'), max_length=255)
    description = models.TextField(_('description'), blank=True)

    class Meta:
        verbose_name = _('category')
        verbose_name_plural = _('categories')
        db_table = 'content\".\"category'

    def __str__(self):
        return self.title


class Product(BaseModel, TimeStampedModel):
    title = models.CharField(_('title'), max_length=255)
    description = models.TextField(_('description'), blank=True)
    address = models.CharField(_('address'), max_length=255)
    price_one_day = models.PositiveIntegerField(_('price one day'), blank=True)
    price_three_days = models.PositiveIntegerField(_('price three_days'), blank=True)
    price_seven_days = models.PositiveIntegerField(_('price seven days'), blank=True)
    price_seven_month = models.PositiveIntegerField(_('price seven month'), blank=True)
    rating = models.FloatField(_('rating'), validators=[MinValueValidator(0)], blank=True)
    user_id = models.UUIDField(default=uuid.uuid4, editable=False)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)

    class Meta:
        verbose_name = _('product')
        verbose_name_plural = _('products')
        db_table = "content\".\"product"

    def __str__(self):
        return self.title


class Image(BaseModel):
    url = models.CharField(_('url'), max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = _('image')
        verbose_name_plural = _('images')
        db_table = 'content\".\"image'

    def __str__(self):
        return self.id


class ImageProduct(BaseModel):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    image = models.ForeignKey(Image, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "content\".\"image_product"
        unique_together = (('product_id', 'image_id'),)
