#!/usr/bin/env bash
# autor: HenriqueAD <www.osistematico.com.br>
# descrição: Converte lote de imagens no perfil de cores RGB para um perfil sRGB e por fim em CMYK para impressão. 
# version: 1.0
# licença: MIT License


# PERFIL ICC sRGB
icc_profile_sRGB="/home/henriquead/.cmyk/sRGB-elle-V2-srgbtrc.icc"

# PERFIL ICC CMYK
icc_profile_CMYK="/home/henriquead/.cmyk/Coated_Fogra39L_VIGC_300.icc"


#EXIBE MENSAGEM INICIAL
zenity --info --title="Conversor de imagens RGB para CMYK" --width=400 --height=150 --text="Converta imagens no perfil de cores RGB para CMYK"  --timeout=5

# SELECIONA A PASTA DE ORIGEM COM AS IMAGENS NO PERFIL DE CORES RGB
input_ORIGEM_dir=$(zenity --file-selection --directory --title "Selecione a pasta de origem com as imagens RGB")

# VERIFICA SE A PASTA DE ORIGEM CONTÉM IMAGENS PNG OU JPEG
if ! (find "$input_ORIGEM_dir" -type f \( -name "*.png" -o -name "*.jpeg" -o -name "*.jpg" \) | grep -q .); then
    # Caso não contenha, exibe mensagem e finaliza o script
    zenity --info --title="Pasta sem imagens!" --width=400 --height=150 --text "Nenhuma imagem PNG ou JPEG encontrada na pasta de origem. É necessário selecionar uma pasta com imagens neste formato." --timeout=10
    exit 1
fi

# CRIA PASTA DE DESTINO PARA IMAGENS sRGB - DENTRO DA PASTA ORIGEM
output_sRGB_dir="$input_ORIGEM_dir/sRGB"
mkdir -p "$output_sRGB_dir"

# CRIA PASTA DE DESTINO PARA IMAGENS CMYK - DENTRO DA PASTA ORIGEM 
output_CMYK_dir="$input_ORIGEM_dir/CMYK"
mkdir -p "$output_CMYK_dir"

# CONVERTE LOTE DE IMAGENS RGB para sRGB - USANDO A PASTA SELECIONADA COMO ORIGEM
count=$(find "$input_ORIGEM_dir" -type f \( -name "*.png" -o -name "*.jpeg" -o -name "*.jpg" \) | wc -l)
current=0

for file in "$input_ORIGEM_dir"/*; do
    if [[ $(file -b --mime-type "$file") == "image/jpeg" || $(file -b --mime-type "$file") == "image/png" ]]; then
        filename=$(basename "$file")
        output_file="$output_sRGB_dir/${filename%.*}.jpeg"
        convert "$file" -profile "$icc_profile_sRGB" "$output_file"
    fi
    
# CONTADOR DENTRO DO LOOP MARCANDO PROGRESSO DA CONVERSÃO
    ((current++))
    progress=$((current * 100 / count))
    echo "# Conversão: $progress% concluída..."
done | zenity  --progress --title "Convertendo imagens para sRGB" --auto-close

# CONVERTE LOTE DE IMAGENS sRGB para CMYK - USANDO A PASTA sRGB COMO ORIGEM
count=$(find "$output_sRGB_dir" -type f \( -name "*.jpeg" -o -name "*.jpg" \) | wc -l)
current=0

for file in "$output_sRGB_dir"/*; do
    filename=$(basename "$file")
    output_file="$output_CMYK_dir/${filename%.*}.jpeg"
    convert "$file" -profile "$icc_profile_CMYK" "$output_file"
    
# CONTADOR DENTRO DO LOOP MARCANDO PROGRESSO DA CONVERSÃO
    ((current++))
    progress=$((current * 100 / count))
    echo "# Conversão: $progress% concluída..."
done | zenity --progress --title "Convertendo imagens para CMYK" --auto-close

# EXCLUI A PASTA sRGB E SEUS ARQUIVOS
rm -r "$output_sRGB_dir"

# MENSAGEM DE CONVERSÃO CONCLUÍDA
zenity --info --title="Conversão concluída!" --width=400 --height=150 --text="Conversão de imagens no perfil de cores RGB para CMYK concluída com sucesso!"  --timeout=5


exit
