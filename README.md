# MSC_AI_UNIR
Repo for the projects submitted during the AI Master's program


## Set up
Para asegurar consistencia utilizaremos todos **python version = 3.11.0**, además usaremos `pyenv` para la gestión de versiones de python y `poetry` para gestionar virtualenvs y dependencias. Estas tecnologías son una elección en cierta medida arbitraria, aunque las herramientas utilizadas son ampliamente utilizadas, hay otras opciones como `venv`, `virtualenv` o `pipenv` para virtualenvs, o conda para gestión de paquetes, que también se utilizan de forma extensa.

**RECORDAD: Es importante no utilizar el python del sistema ya que acabaremos teniendo conflictos entre proyectos muy rápido. Por eso, utilizaremos siempre un virtualenv separado para cada proyecto.**

Para configurar nuestro entorno de trabajo primero instalamos python 3.11.0 en el ordenador usando pyenv `pyenv install 3.11.0`. 
Después, una vez estemos en el repositorio de trabajo (tras haber hecho un fork del repositorio original), nos aseguramos de que estamos utilizando ese python localmente `pyenv local 3.11.0`. Podemos comprobar que todo está correcto mediante el comando `pyenv versions`, que nos debería mostrar 3.11.0 con un asterisco que denota que es la versión utilizada en el directorio actual. IMPORTANTE: si utilizáis ubuntu con WSL es posible que poetry no utilice la versión local de `pyenv` y sea necesario forzarlo con `poetry env use 3.11.0` [ver aquí](https://stackoverflow.com/questions/70950511/using-poetry-with-pyenv-and-having-python-version-issues).

Una vez asegurada que la versión de python es correcta pasamos a instalar las dependencias iniciales definidas en `pyproject.toml` mediante el comando `poetry install`. Una vez instaladas, si necesitamos añadir una nueva dependencia podemos hacerlo con `poetry add <paquete>`.