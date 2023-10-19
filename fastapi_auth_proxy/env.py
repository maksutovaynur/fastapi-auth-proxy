from environs import Env

env = Env()

ACCESS_USERNAME = env.str('ACCESS_USERNAME')
ACCESS_PASSWORD = env.str('ACCESS_PASSWORD')

APP_HOST = env.str('APP_HOST')
APP_PORT = env.int('APP_PORT')

REDIRECT_URL = env.str('REDIRECT_URL')
