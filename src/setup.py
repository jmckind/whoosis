import os
from setuptools import find_packages, setup

# allow setup.py to be run from any path
os.chdir(os.path.normpath(os.path.join(os.path.abspath(__file__), os.pardir)))

setup(
    name='whoosis',
    version='0.1.1a2',
    packages=find_packages(),
    include_package_data=True,
    license='MIT License',
    description='A simple web application for demonstration purposes.',
    long_description='Whoosis is a simple Django web application for demonstration purposes.',
    url='https://github.com/jmckind/whoosis/',
    author='John McKenzie',
    author_email='jmckind@gmail.com',
    classifiers=[
        'Environment :: Web Environment',
        'Framework :: Django',
        'Framework :: Django :: 1.11',
        'Intended Audience :: Developers',
        'License :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Internet :: WWW/HTTP :: Dynamic Content',
    ],
    install_requires=[
        'colorlog==3.1.0',
        'Django==1.11.6',
        'dumb-init==1.2.0',
        'gunicorn==19.7.1',
        'mysqlclient==1.3.12',
        'pytz==2017.3'
    ],
    extras_require={
        'dev': [
            'check-manifest',
            'coverage',
            'django-nose',
            'nose',
            'psycopg2',
        ],
    },
)
