echo "🧹 Limpando cache e arquivos antigos..."
hugo --gc

#!/bin/bash

# Configurações iniciais
echo -e "\033[1;31m"  # Vermelho brilhante

# Efeito de inicialização (simulando um terminal sendo corrompido)
for i in {1..5}; do
  echo "INJECTING CODE... $i/5" | toilet -f term --gay | lolcat
  sleep 0.3
done

# ASCII-art principal (estilo "bloody hacker")
figlet -f slant "PYTHON SERVER" | lolcat -p 0.7
echo -e "___________________________________________________________" | lolcat

# Mensagem de status (com efeito glitch)
toilet -f term -F border --gay "PORT: 8000"
echo -e "\033[1;31m> WARNING: THIS IS A HONEYPOT. ALL ACTIVITY IS LOGGED." | pv -qL 20
echo -e "\033[1;32m> SERVER INITIATED AT: $(date)"
echo -e "\033[1;31m> TRACE ROUTE INITIATED. TARGET: YOUR LOCATION" | pv -qL 15 | pv -qL 20
echo -e "\033[0m"  # Reset de cor

echo "🚀 Gerando o site com Hugo..."
hugo

echo "🌐 Iniciando servidor local na pasta public (porta 8080)..."
cd public
python -m http.server 8080
