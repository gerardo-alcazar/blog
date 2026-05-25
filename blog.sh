#!/bin/bash

# Script para automatizar mi blog Hugo
BLOG_DIR="$HOME/blog"
cd "$BLOG_DIR" || exit

function nuevo() {
    if [ -z "$1" ]; then
        echo "Uso: ./blog.sh nuevo \"Titulo del Post\""
        return
    fi
    # Generar nombre de archivo amigable
    FILENAME=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-').md
    
    # Crear el post
    hugo new content "posts/$FILENAME"
    
    # Quitar el modo draft automáticamente (opcional, pero más rápido)
    sed -i '' 's/draft = true/draft = false/g' "content/posts/$FILENAME"
    
    echo "✨ Post creado: content/posts/$FILENAME"
    echo "📝 Abriendo para editar..."
    open "content/posts/$FILENAME"
}

function publicar() {
    echo "🚀 Subiendo cambios a GitHub..."
    git add .
    git commit -m "Publicación automática: $(date +'%Y-%m-%d %H:%M')"
    git push origin main
    echo "✅ ¡Listo! En un par de minutos estará vivo en internet."
}

case "$1" in
    nuevo)
        nuevo "$2"
        ;;
    publicar)
        publicar
        ;;
    *)
        echo "Comandos disponibles:"
        echo "  ./blog.sh nuevo \"Nombre del post\" - Crea y abre un nuevo post"
        echo "  ./blog.sh publicar                - Sube todos los cambios a GitHub"
        ;;
esac
