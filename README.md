# RGB_to_CMYK
Converta em lote imagens no perfil de cores RGB para CMYK

**RGB_to_CMYK** é um shell script Linux que faz uso dos utilitários **Imagemagick**, para conversão das imagens, e **Zenity** para interface gráfica.
Originalmente este script era apenas de uso interno, afim de converter minhas imagens em png/jpeg no perfil de cores RGB para CMYK, mas sem uma interface gráfica e tratamento de erros simples.

Atualmente o RGB_to_CMKY possui uma interface interativa em Zenity bem simples, mas que torna a experiência rica, basta selecionar a pasta de origem com as imagens e esperar o termino da conversão.

***

## Funções do RGB_to_CMYK
O padrão de cores RGB é largamente utilizado para arquivos que se destinam à visualização em telas, enquanto o CMYK é destinado à impressão física. Com o intuito de converter minhas imagens e obter o mais próximo possível do range de cores que estou vendo na tela em minhas impressões, resolvi criar esse simples utilitário em shell script.

Obviamente que existe uma diferença consideravel entre as cores em RGB e CMYK, sendo aconselhável criar seus arquivos com finalidade para impressão dês do inicío com CMYK. No entanto nem sempre existe essa possibilidade.

RGB_to_CMYK primeiro converte as imagens em um perfil de cores sRGB (**sRGB-elle-V2-srgbtrc.icc**) para só então conerter para um perfil CMYK (**Coated_Fogra39L_VIGC_300.icc**). Isso é feito para melhor controle de cores e um resultado mais apróximo possível dos arquivos originais.

É bem simples utilizar o RGB_to_CMYK, bastando escolher a pasta de origem com os arquivos à serem convertidos e ao finalizar o processo uma pasta de nome "CMYK" (no diretório de origem) será criada com todas as imagens em CMYK.

Observe que dependendo do seu gerenciador de arquivos, como também o visualizador de imagens, arquivos em CMYK podem tomar uma coloração bem estranha em telas RGB. Aconselho ver o resultado com o apoio do software Krita. Abrindo sua imagem convertida por ele, poderá ver o resultado real que aparecerá na impressão.

***

## RGB_to_CMYK em AppImage
Para facilitar o uso do RGB_to_CMYK empacotei o mesmo em AppImage, bastando dar as permissões de execução uma única vez e dando dois cliques sobre o mesmo. Fique ciente que ao utilizar o RGB_to_CMYK no formato shell script é preciso adicionar e configurar o caminho onde os perfis ICC se encontram, além de ter o Imagemagick em seu sistema. No AppImage nenhuma configuração deste tipo é necessária. É possível integrar o AppImage via **AppImageLauncher** e similares ao menu do seus sitema (esteja ciente que por se tratar de um utilitário script baseado em Zenity terá um ícone genérico).

[Baixe o RGB_to_CMYK em AppImage!](https://github.com/henriquead7/RGB_to_CMYK/releases/download/v1.1/RGB_to_CMYK-x86_64.AppImage)

***

## Considere apoiar o projeto OSistemático

[Apoia.se](https://apoia.se/osistematico) |
[Youtube](https://www.youtube.com/OSistematico) |
[Site](http://www.osistematico.com.br/) |
[Twitter](https://twitter.com/henriquead7)

***Obrigado pela atenção e apoio de todos, SISTEMATICAMENTE!***
