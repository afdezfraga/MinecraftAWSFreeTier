# MinecraftAWSFreeTier

Proyecto para desplegar un server de Minecraft en AWS usando tecnologías DevOps y IaC.

El objetivo es hacer el despliegue completamente en la capa gratuita de AWS para tener un servidor de Minecraft 1.17+ con 0 costes.

La dificultad extra que trae esta versión es que requiere Java 16, que no se puede instalar de forma estandar usando los gestores de paquetes (al menos a día de hoy 15/06/2021).

## Prerequisitos

 - Instalar [Terraform](https://www.terraform.io/downloads.html "Página de descarga de Terraform").
 - Instalar [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html "Página de instalación de Ansible"): ` pip install ansible`.
 - Crear una [cueata gratuita en AWS](https://aws.amazon.com/es/free/) (una cuenta nueva tiene acceso al Free Tier durante 12 meses).

 ## Pasos de configuración iniciales

  - En IAM, crear un usuario con permisos de administrador, tipo acceso a la consola.
  - En IAM, crear un usuario con permisos de adecuados (o de administrador si tienes prisa), tipo acceso mediante programación y guardar la clave y la clave secreta.
  - En EC2, crear un par de claves ssh y guardar la clave privada.
  - Modificar el archivo `$HOME/.aws/configure` y añadir un perfil `[minecraft]` con la clave y clave secreta que hemos guardado.
  - Copiar la clave ssh privada en `$HOME/.ssh/id_rsa`.
  - Clona este repositorio `git clone https://github.com/afdezfraga/MinecraftAWSFreeTier.git`.
  - Modifica las variables de Terraform segun necesites en el fichero `terraform/terraform.tfvars`.
  - Descarga el [JDK de Java 16(Linux x64 Compressed Archive)](https://www.oracle.com/java/technologies/javase-jdk16-downloads.html) y añadelo a la carpeta `ansible/files`.

## Pasos de despliegue: Terraform

Despliega: 
 - Un grupo de seguridad con reglas para SSH y conexiónes de Minecraft.
 - Una instancia EC2 de la capa gratuita con IP pública.

``` sh
cd terraform
terraform init
terraform apply
``` 

Consulta la IP pública asignada a la instancia

``` sh
terraform status show aws_instance.minecraftServer
```

## Pasos de configuración: Ansible

Substituye la IP obtenida en el paso anterior en el fichero `ansible.inventory`. Ejecuta el aprovisionamiento.

``` sh
cd ansible
ansible-playbook -i ../ansible.inventory -u ubuntu playbook.yml
```
