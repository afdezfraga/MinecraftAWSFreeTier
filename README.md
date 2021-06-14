# MinecraftAWSFreeTier

Proyecto para desplegar un server de Minecraft en AWS usando tecnologías DevOps y IaC.

El objetivo es hacer el despliegue completamente en la capa gratuita de AWS para tener un servidor de Minecraft 1.17+ con 0 costes.

La dificultad extra que trae esta versión es que requiere Java 16, que no se puede instalar de forma estandar usando los gestores de paquetes (al menos a día de hoy 15/06/2021).

## Prerequisitos

 - Instalar [Terraform](https://www.terraform.io/downloads.html "Página de descarga de Terraform")
 - Instalar [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html "Página de instalación de Ansible"): ` pip install ansible`
 - Crear una [cueata gratuita en AWS](https://aws.amazon.com/es/free/) (una cuenta nueva tiene acceso al Free Tier durante 12 meses).
