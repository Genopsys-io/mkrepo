# Plugin Zsh : mkrepo

function mkrepo() {
  local repo_name=$1
  local repo_account=$2

  if [[ -z "$repo_name" ]]; then
    echo "❌ Usage: mkrepo <owner>/<repo>"
    return 1
  fi

  echo "📁 Initialisation du dépôt Git..."
  git init .

  echo "📦 Ajout et commit initial..."
  git add .
  git commit -m "First commit"

  echo "🌐 Création du dépôt GitHub '$repo_name' (privé)..."
  gh repo create "$repo_account/$repo_name" --private

  echo "🔗 Ajout du remote origin..."
  git remote add origin "https://github.com/$repo_account/$repo_name.git"

  echo "🚀 Push vers main..."
  git push -u origin main

  echo "🏷️  Tag le plus proche (si présent) :"
  git describe --tags --abbrev=0 2>/dev/null || echo "Aucun tag trouvé."
}