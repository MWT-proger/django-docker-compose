# для вода через cmd предусмотрено два аргумента
# v - тип сборки (dev или prod)
# c - сонкретный сервис

ifeq ($(v),prod)
	w=
	collect=docker-compose -f docker-compose.$(v).yml exec web python manage.py collectstatic --noinput
	makemigrations=
else
	w=_dev
	collect=
	makemigrations=docker-compose -f docker-compose.$(v).yml exec web$(w) python manage.py makemigrations
endif

# Команды

full_run: build up update create_user

run: up update

build:
	docker-compose -f docker-compose.$(v).yml build $(c)

up:
	docker-compose -f docker-compose.$(v).yml up -d $(c)

start:
	docker-compose -f docker-compose.$(v).yml start $(c)

down:
	docker-compose -f docker-compose.$(v).yml down $(c)

destroy:
	docker-compose -f docker-compose.$(v).yml down -v $(c)

stop:
	docker-compose -f docker-compose.$(v).yml stop $(c)

restart:
	docker-compose -f docker-compose.$(v).yml stop $(c)
	docker-compose -f docker-compose.$(v).yml up -d $(c)

run:
	docker-compose -f docker-compose.$(v).yml up --build -d

update:
	$(makemigrations)
	docker-compose -f docker-compose.$(v).yml exec web$(w) python manage.py migrate products --fake
	docker-compose -f docker-compose.$(v).yml exec web$(w) python manage.py migrate
	$(collect)

create_user:
	docker-compose -f docker-compose.$(v).yml exec web$(w) python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'adminpass')"
