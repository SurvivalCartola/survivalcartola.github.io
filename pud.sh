play -nq -t alsa synth 0.1 sine 800
play -nq -t alsa synth 0.1 sine 1000

echo "🔍 Verificando conexão SSH com GitHub..."
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
if [ $? -ne 0 ]; then
  echo "❌ Erro: A autenticação SSH com GitHub falhou."
  play -nq -t alsa synth 0.2 sine 300
  echo "💡 Verifique se sua chave está corretamente configurada."
  exit 1
fi

echo "✅ SSH verificado com sucesso."
play -nq -t alsa synth 0.1 sine 1200

# Gerar site estático com Hugo
echo "⚙️ Gerando site com Hugo..."
hugo
if [ $? -ne 0 ]; then
  echo "❌ Erro ao gerar site com Hugo."
  play -nq -t alsa synth 0.2 sine 400
  exit 1
fi

# Commit e Push

git add .
git commit -m "PUBLICAÇÃO_AUTOMATICA $(date +'%Y-%m-%d %H:%M:%S')"
git push -u origin main

play -nq -t alsa synth 0.1 sine 1500
play -nq -t alsa synth 0.1 sine 1800
play -nq -t alsa synth 0.2 sine 2000
