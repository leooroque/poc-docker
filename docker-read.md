
# Docker

O Docker é uma plataforma aberta para desenvolvimento, envio e execução de aplicativos. O objetivo do docker é que você possa gerenciar sua infraestrutura do mesmo jeito que gerencia seus aplicativos(softwares), ou seja, infraestrutura como código ([IaC](https://pt.wikipedia.org/wiki/Infraestrutura_como_C%C3%B3digo)). Além disso ele permite que você consiga utilizar imagens de ambientes completos para realização de promoção entre as camadas(prd/hml/dev) garantindo a integridade do software em todas as etapas.

*Benefícios:*
- Agilidade no provisionamento de ambientes;
- Equalização dos ambientes;
- IaC;
- Precisa de pouco recurso computacional para rodar;


## Versões
O Docker está disponível em 3 versões, sendo elas: 

- Docker Engine - Community
- Docker Engine - Enterprise
- Docker Enterprise

> **Docker Engine - Community**
Versão ideal para desenvolvedores que querem começar a utilizar o Docker.

> **Docker Engine - Enterprise**
 Versão projetada para o desenvolvimento corporativo, nessa versão ja temos uma SLA de atendimento para as empresas que adotam.

 > **Docker Enterprise**
 Versão projetada para grandes corporações que utilizam o docker no core dos seus negócios, assim como a versão citada acima também possui uma SLA. 

## Motor do Docker 

O docker engine é um aplicativo cliente-servidor, sendo que os principais componentes são:

- Um servidor de longa duração que roda em background(plano de fundo) como um processo daemon.(comando *dockerd*)

**Curiosidade**
>*Em sistemas operacionais multitarefa, um daemon é um programa de computador que executa como um processo em plano de fundo, em vez de estar sob o controle direto de um usuário interativo. Tradicionalmente, o nome de processo de um daemon termina com a letra d, para deixar claro que o processo é, de fato, um daemon, e para diferenciação entre um daemon e um programa de computador normal.[1] Por exemplo, syslogd é o daemon que implementa o recurso de logging do sistema e sshd é um daemon que serve conexões SSH de entrada.*

- Uma API REST que especifica interfaces que os progamas podem usar para conversar com o daemon e instruir  o que fazer.

- Um cliente CLI(interface de linha de comandos). (Comando *docker*)

<iframe src="https://drive.google.com/file/d/1ow0eAlTxt1WD6W_DVaw7XPGXcAnY-296/preview" width="640" height="480"></iframe>

A CLI usa a API REST do Docker para controlar ou interagir com o daemon do Docker por meio de scripts ou comandos diretos da CLI. Muitos outros aplicativos do Docker usam a API e a CLI subjacentes.

**O daemon cria e gerencia objetos do Docker , como imagens, contêineres, redes e volumes.**

## Arquitetura Docker

O Docker usa uma arquitetura cliente-servidor. O cliente do Docker fala com o daemon do Docker , que faz o trabalho pesado de construir, executar e distribuir contêineres do Docker. O cliente e o daemon do Docker podem ser executados no mesmo sistema ou você pode conectar um cliente do Docker a um daemon do Docker remoto. O cliente e o daemon do Docker se comunicam usando uma API REST, sobre soquetes UNIX ou uma interface de rede.

<iframe src="https://drive.google.com/file/d/19-MA2Cl6MrbbsH5mjR1Ufxoa0sf1Zrrs/preview" width="640" height="480"></iframe>


### O daemon do Docker (Docker daemon)
O daemon do Docker (*dockerd*) ouve as solicitações da API do Docker e gerencia objetos do Docker, como imagens, contêineres, redes e volumes. Um daemon também pode se comunicar com outros daemons para gerenciar os serviços do Docker.

### O cliente do Docker (Docker client)
O cliente do Docker (*docker*) é a principal maneira como muitos usuários do Docker interagem com o Docker. Quando você usa comandos como ```docker run```, o cliente envia esses comandos para **dockerd**(daemon), que os executa. O comando **docker** usa a API do Docker. O cliente do Docker pode se comunicar com mais de um daemon.

### Registros Docker (Docker registries)
O registro do Docker armazena imagens do Docker. O **Docker Hub** é um repositório público que qualquer um pode usar, **e o Docker é configurado para procurar imagens no Docker Hub por padrão**. Você pode até mesmo executar o seu próprio registro privado. Se você usa o Docker Datacenter (DDC), ele inclui o DTR (Docker Trusted Registry).

Quando você usa os comandos ```docker pull``` ou ```docker run```, as imagens necessárias são extraídas do registro configurado. Quando você usa o ```docker push```, sua imagem é enviada para o registro configurado.

## Objetos Docker (Docker objects)

Ao usar o Docker, você está criando e usando imagens, contêineres, redes, volumes, plug-ins e outros objetos.

### Imagens 

Uma imagem é um modelo somente leitura com instruções para criar um contêiner Docker. Muitas vezes, **uma imagem é baseada em outra imagem, com alguma personalização adicional**. Por exemplo, você pode criar uma imagem baseada na ubuntu, mas instala o servidor web Apache e seu aplicativo, bem como os detalhes de configuração necessários para executar seu aplicativo.

Você pode criar suas próprias imagens ou usar somente aquelas criadas por outras pessoas e publicadas em um registro. **Para criar sua própria imagem, crie um Dockerfile com uma sintaxe simples para definir as etapas necessárias para criar a imagem e executá-la.** Cada instrução em um Dockerfile cria uma camada na imagem. Quando você altera o Dockerfile e recria a imagem, apenas as camadas que foram alteradas são reconstruídas. Isso faz com que as imagens sejam tão leves, pequenas e rápidas quando comparadas a outras tecnologias de virtualização.

### Containers

Um contêiner é uma instância executável de uma imagem. Você pode criar, iniciar, parar, mover ou excluir um contêiner usando a API do Docker ou o CLI. Você pode conectar um contêiner a uma ou mais redes, anexar armazenamento a ele ou até mesmo criar uma nova imagem com base em seu estado atual.

**Por padrão, um contêiner é relativamente bem isolado de outros contêineres e de sua máquina host.** Você pode controlar o quão isolada a rede, o armazenamento ou outros subsistemas subjacentes de um contêiner são de outros contêineres ou da máquina host.

Um contêiner é definido por sua imagem e por todas as opções de configuração que você fornece quando cria ou inicia. **Quando um contêiner é removido, quaisquer alterações em seu estado que não são armazenadas no armazenamento persistente desaparecem.**

**Containers são:**
>Flexível: Até mesmo os aplicativos mais complexos podem ser contêinerizados.
Leve: os contêineres aproveitam e compartilham o kernel do host.
Intercambiável: você pode implantar atualizações e up-on-the-fly.
Portátil: você pode criar localmente, implantar na nuvem e executar em qualquer lugar.
Escalável: você pode aumentar e distribuir automaticamente as réplicas do contêiner.
Empilhável: você pode empilhar serviços vertical e on-the-fly.


### Serviços (Services)

Os serviços permitem dimensionar contêineres em vários *daemons* do Docker, que trabalham juntos como um *swarm* com vários gerentes e funcionários . Cada membro de um swarm é um daemon do Docker, **e todos os daemons se comunicam usando a API do Docker.** Um serviço permite que você defina o estado desejado, como o número de réplicas do serviço que devem estar disponíveis a qualquer momento. Por padrão, o serviço é balanceado por carga em todos os nós do trabalhador. Para o consumidor, o serviço Docker parece ser um único aplicativo.


# Container vs. VM's

<iframe src="https://drive.google.com/file/d/1hgg4tktTs2zAApzO-bOjV1S535UttiU0/preview" width="300" height="240"></iframe>
VS
<iframe src="https://drive.google.com/file/d/1k_eWBNLQVeUPdLZm1AZSPaxcIoKovnuN/preview" width="300" height="240"></iframe>

Como podemos ver nas imagens acima o container utiliza o kernel do próprio host, ou seja, ele não ocupa mais memória que qualquer outro aplicativo que está sendo executado o tornando mais leve principalmente se comparado a uma VM que utiliza um novo S.O consumindo mais recursos do host. 

## Instalação
**Agora que sabemos um pouco mais sobre o docker, partiu instalar !**

Vale lembrar que essa instalação é para (**Windows**)

Requisitos de sistema:
- Windows 10 de 64 bits: Pro, Enterprise ou Education (Build 15063 ou posterior).
- A virtualização está habilitada no BIOS. Normalmente, a virtualização é ativada por padrão. Isso é diferente de ter o Hyper-V ativado. Para mais detalhes, consulte Virtualização deve estar ativado em Solução de problemas.
- Recurso compatível com CPU SLAT.
- Pelo menos 4 GB de RAM.

Para você que tem o mesmo notebook que eu, tenho uma surpresa ! **Nossa máquina não atende os resquisitos.**

Calma, claro que temos um caminho alternativo meu caro amigo ! Aí vai !

>Se o seu sistema não atender aos requisitos para executar o Docker Desktop for Windows, você poderá instalar o [Docker Toolbox](https://github.com/docker/toolbox/releases) (Selecionar a versão mais atual) , que usa o Oracle Virtual Box em vez do Hyper-V.

**Para quem atende os requisitos o ideal é utilizar direto o [docker desktop for windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)**


>Você é solicitado a autorizar Docker.app com sua senha do sistema durante o processo de instalação. O acesso privilegiado é necessário para instalar componentes de rede, links para os aplicativos Docker e gerenciar as VMs do Hyper-V. (Isso só acontece quando você instala o docker for windows o toolbox utiliza o Oracle Virtual Box).

Após a instalação abra o prompt de comando e execute:

```
docker --version
```
Nessa data (31/07/2019) a última versão do docker é:
>Docker version 18.09.3, build 774a1f4eee

Se sua instalação deu certo, após clicar no ícone do docker toolbox você estará nesse terminal.
<iframe src="https://drive.google.com/file/d/1LjfQG4RtuWGRGt9oKP_6IoRMHlRTbyuW/preview" width="640" height="480"></iframe>
##**Partiu fazer um Hello world ? Bora!** 

```
docker run hello-word
```

<iframe src="https://drive.google.com/file/d/1alDesTKq8tJbGXf30OnGlWRupv5NB9r8/preview" width="640" height="480"></iframe>

### O que podemos identificar com o retorno desse log ? 
Conforme explicado acima o docker tem um repositório local onde ele grava as imagens e um repositório web mais conhecido como [Docker HUB](https://hub.docker.com/), como nós não tinhamos nenhuma imagem chamada hello-world localmente ele fez o download dessa imagem do dockerhub e criou o container como podemos ver nas linhas abaixo.

> Com o comando *docker image ls* nós podemos listar as imagens que temos localmente para serem utilizadas e agora que baixamos uma imagem do dockerhub ela deveria aparecer.

```
docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              fce289e99eb9        7 months ago        1.84kB
```

### Lembra que eu disse que nós rodamos um container  ?

```
docker container ls --all
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
47d0b59e38f6        hello-world         "/hello"            18 minutes ago      Exited (0) 13 minutes ago                       kind_newton
```

Simples, rápido, fácil e indolor ! Isso é o docker.

## DOCKERFILE

Bom agora que você ja entendeu o que é o docker e ja fez o seu "olá mundo" vamos aprender um pouco sobre o dockerfile.
O Dockerfile em si pode ser considerado a parte do IaC (Infraestrutura como código), com ele nós temos uma receita de bolo para montar o nosso container e conseguimos especificar todos os detalhes em sua criação, como por exemplo:

- Qual aplicativo vamos rodar dentro do container;
- Qual porta será disponibilizadas nesse aplicativo;
- Quais dependencias;

Levando isso em consideração podemos mudar nossa visão com relação a infraestrutura, agora com o dockerfile nós podemos versionsar essa "receita", todos os desenvolvedores terão acesso a um ambiente com as mesmas caracteristicas mitigando possiveis problemas de ambiente.

## **Bora fazer a POC.**

Os arquivos citados nos comandos abaixo estão no GIT e podem ser baixados.

