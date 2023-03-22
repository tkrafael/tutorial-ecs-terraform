# O que é necessário para rodar um service ECS na AWS

1. Cluster
2. Task Definition
3. Service

## Conceitos

### Cluster
É onde as máquinas/vms/instãncias serão agrupadas.
<br/>

#### Cluster: Capacity providers
É a configuração que permite o cluster g# O que é necessário para rodar um service ECS na AWS

1. Cluster
2. Task Definition
3. Service

## Conceitos

### Cluster
É onde as máquinas/vms/instãncias serão agrupadas.
<br/>

#### Cluster: Capacity providers
É a configuração que permite o cluster gerenciar as máquinas que estão rodando, aumentando e diminuindo a quantidade de máquinas conforme a demanda por capacidade for sendo necessária

#### Cluster: Capacity Providers: Fargate

#### Cluster: Capacity Providers: EC2

#### Cluster: Capacity Provider: AutoScaling Group

### Tasks / Task Definition
O que é uma task definition

### Service
- O que é um ecs service?
- Diferenças entre uma task e um service


## Terraform: O que é?

## Terragrunt: O Que é?

## Aplicação

O que é necessário para integrar uma aplicação ao ECS
1. Log: opção pelo firehose
2. Configuração: SSM Parameters
3. Métricas (open telemetry, telegraf, cloudwatch)
4. Alarmística: (cloudwatch, zabbix, grafana)