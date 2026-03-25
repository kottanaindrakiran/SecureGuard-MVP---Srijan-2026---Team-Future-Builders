from setuptools import setup, find_packages

setup(
    name='secureguard-cli',
    version='1.0.0',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'click',
        'rich',
        'requests',
    ],
    entry_points={
        'console_scripts': [
            'sg=secureguard.cli:main',
        ],
    },
)
