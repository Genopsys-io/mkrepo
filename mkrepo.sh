function mkrepo() {
  local input=$1

  if [[ -z "$input" || "$input" != *"/"* ]]; then
    echo "❌ Usage: mkrepo <owner>/<repo> (e.g., myCompany-io/myApp)"
    return 1
  fi

  local repo_account="${input%%/*}"
  local repo_name="${input##*/}"

  if ! command -v gh &>/dev/null; then
    echo "❌ 'gh' CLI is not installed. Install it from https://cli.github.com/"
    return 1
  fi

  if [ -d ".git" ]; then
    echo "📁 Dépôt Git déjà initialisé."
  else
    echo "📁 Initialisation du dépôt Git..."
    git init .
  fi

  echo "📦 Ajout et commit initial..."
  git add .
  git commit -m "First commit"

  echo "🌐 Création du dépôt GitHub '$owner/$repo' (privé)..."
  gh repo create "$owner/$repo" --private

  echo "🔗 Ajout du remote origin..."
  git remote add origin "https://github.com/$owner/$repo.git"

  echo "🚀 Push vers main..."
  git push -u origin main

  echo "🏷️  Tag le plus proche (si présent) :"
  git describe --tags --abbrev=0 2>/dev/null || echo "Aucun tag trouvé."
}
