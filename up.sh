vagrant ssh -c "cd /project && bower install && grunt" & &&\
vagrant ssh -c "cd /project && ./manage.py runserver"
