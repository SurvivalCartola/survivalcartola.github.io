#!/data/data/com.termux/files/usr/bin/bash

figlet "Cartola Survival" | lolcat
toilet -f term -F border "Publisher" | lolcat
echo "─────────────────────────────────────────────" | pv -qL 20
echo " 🛡️  Publicador automático de artigos Hugo" | pv -qL 20
echo " 🌐 Repositório: survivalcartola.github.io" | pv -qL 20
echo "─────────────────────────────────────────────" | pv -qL 20

# Nome correto do repositório GitHub Pages
REPO_URL="git@github.com:SurvivalCartola/survivalcartola.github.io.git"

# Beep de início
play -nq -t alsa synth 0.2 sine 800
play -nq -t alsa synth 0.2 sine 1000

echo "🔍 Verificando conexão SSH com GitHub..."
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
if [ $? -ne 0 ]; then
  echo "❌ Erro: A autenticação SSH com GitHub falhou."
  play -nq -t alsa synth 0.4 sine 300
  echo "💡 Verifique se sua chave está corretamente configurada."
  exit 1
fi

echo "✅ SSH verificado com sucesso."
play -nq -t alsa synth 0.2 sine 1200

# Gerar site estático com Hugo
echo "⚙️ Gerando site com Hugo..." | pv -qL 10
hugo
if [ $? -ne 0 ]; then
  echo "❌ Erro ao gerar site com Hugo."
  play -nq -t alsa synth 0.4 sine 400
  exit 1
fi

# Ir para pasta 'public'
cd public || {
  echo "❌ Erro: Pasta 'public' não encontrada."
  play -nq -t alsa synth 0.4 sine 200
  exit 1
}

# Verificar e corrigir URL remota se necessário
REMOTE_URL=$(git remote get-url origin 2>/dev/null)

if [ "$REMOTE_URL" != "$REPO_URL" ]; then
  echo "⚠️ Repositório remoto incorreto. Corrigindo..."
  git remote remove origin 2>/dev/null
  git remote add origin "$REPO_URL"
  echo "✅ Repositório remoto configurado para:"
  echo "   $REPO_URL"
  play -nq -t alsa synth 0.3 sine 1000
fi

# Commit e Push
echo "📦 Adicionando alterações ao Git..."
git add .

echo "📝 Criando commit..."
git commit -m "Atualização automática: $(date +'%Y-%m-%d %H:%M:%S')" || {
  echo "⚠️ Nenhuma alteração para commit."
}

echo "🚀 Enviando para o GitHub Pages..."
git push -u origin main

# Beep final de sucesso
play -nq -t alsa synth 0.2 sine 1500
play -nq -t alsa synth 0.2 sine 1800
play -nq -t alsa synth 0.4 sine 2000

echo "✅ Publicação finalizada. Verifique seu site em:"
echo "🌐 https://survivalcartola.github.io"
