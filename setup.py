from distutils.core import setup

setup(
    name='SAJOB.py',
    version='',
    packages=[''],
    url='',
    license='',
    author='Simon',
    author_email='',
    description=''
)


def install_and_import(package):
    import importlib
    try:
        importlib.import_module(package)
    except ImportError:
        import pip
        pip.main(['install', package])
    finally:
        globals()[package] = importlib.import_module(package)


install_and_import('pyodbc')
install_and_import('cx_Oracle')