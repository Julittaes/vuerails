To setup and start application run

1) bundle install

2) rails db:create db:migrate

3) foreman start -f Procfile.dev

4) open on http://localhost:5100

To check all existing routes you can run 'rails routes' from console

You can fill the database with some data by running 'rails db:seed' from console