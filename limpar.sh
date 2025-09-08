#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🧹 Iniciando limpeza do build Hugo...${NC}"

# Limpa os arquivos de build
rm -rf public/ resources/_gen/ .hugo_build.lock

echo -e "${GREEN}✅ Limpeza concluída!${NC}"

# Toca som de conclusão com Sox
echo -e "${YELLOW}🎵 Tocando som de conclusão...${NC}"

# Verifica se o Sox está instalado
if command -v play &> /dev/null; then
    # Som de sino (curto e agradável)
    play -q -n synth 0.1 sin 880 vol 0.5 >/dev/null 2>&1

    # Som adicional de confirmação
    play -q -n synth 0.2 sin 1046.5 vol 0.3 >/dev/null 2>&1

    echo -e "${GREEN}🎶 Som executado com sucesso!${NC}"
else
    echo -e "${RED}⚠️ Sox não instalado. Instale com: pkg install sox${NC}"
fi

echo -e "${GREEN}🚀 Pronto para rodar 'hugo' ou 'hugo server'!${NC}"
