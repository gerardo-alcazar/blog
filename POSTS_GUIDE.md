# Manual para escribir posts en El Blog de Gerardo

## 1. Crear un nuevo post

Usa el script `blog.sh` desde la raíz del blog (`/Users/gerardoalcazar/blog`):

```bash
./blog.sh nuevo "Título del Post"
```

Esto crea un archivo en `content/posts/titulo-del-post.md` con el modo `draft = true` y lo abre en tu editor.

Alternativamente, puedes usar Hugo directamente:

```bash
hugo new content "posts/titulo-del-post.md"
```

## 2. Estructura del front matter

Cada post comienza con un bloque de front matter entre `+++`:

```toml
+++
date = '2026-07-27'
draft = true
title = 'Mi Primer Post'
description = 'Una breve descripción del post'
author = 'Gerardo Alcazar'
cover = 'https://example.com/imagen.jpg'
alt = 'Descripción de la imagen de portada'
tags = ['tecnología', 'tutorial']
categories = ['categoría']
+++
```

Campos disponibles:
- `date` — Fecha de publicación
- `draft` — `true` para borrador, `false` para publicar
- `title` — Título del post
- `description` — Descripción para SEO y tarjetas sociales
- `author` — Autor (opcional, usa el del sitio por defecto)
- `cover` o `images` — URL o ruta de la imagen de portada
- `alt`, `coverAlt` o `imagesAlt` — Texto alternativo de la imagen
- `tags` — Etiquetas del post
- `categories` — Categorías del post
- `type` — Tipo de contenido (`post` o `articles`)

## 3. Añadir imágenes dentro de un post

### 3.1 Imágenes en el cuerpo del texto con `figure`

El shortcode `figure` permite insertar imágenes con leyenda y diferentes diseños.

**Sintaxis básica:**

```markdown
{{< figure src="ruta/a/imagen.jpg" caption="Leyenda de la imagen" >}}
```

**Con enlace:**

```markdown
{{< figure src="ruta/a/imagen.jpg" caption="Leyenda" link="https://ejemplo.com" >}}
```

**Tipos de layout:**

| Tipo | Descripción |
|------|-------------|
| (por defecto) | Imagen estándar con leyenda |
| `type="full"` | Imagen a pantalla completa |
| `type="margin"` | Imagen en margen (flotante) |

**Ejemplo con tipo full:**

```markdown
{{< figure src="ruta/a/imagen.jpg" caption="Imagen a pantalla completa" type="full" >}}
```

**Ejemplo con tipo margin:**

```markdown
{{< figure src="ruta/a/imagen.jpg" caption="Imagen en el margen" type="margin" >}}
```

### 3.2 Usar `src="cover"` para la imagen de portada dentro del post

Si ya definiste `cover` en el front matter, puedes reusarla en el cuerpo:

```markdown
{{< figure src="cover" caption="Portada del artículo" >}}
```

### 3.3 Layout tipo Pinterest con `pin`

El shortcode `pin` crea una cuadrícula de imágenes con enlaces:

```markdown
{{< pin img="https://example.com/img1.jpg" url="https://example.com/1" label="Item 1" >}}
{{< pin img="https://example.com/img2.jpg" url="https://example.com/2" label="Item 2" >}}
{{< pin img="https://example.com/img3.jpg" url="https://example.com/3" label="Item 3" >}}
```

### 3.4 Imágenes con texto alternativo

Siempre incluye `alt` para accesibilidad:

**En el front matter (para la portada):**
```toml
alt = 'Descripción descriptiva de la imagen'
```

**En el shortcode figure:**
```markdown
{{< figure src="ruta/a/imagen.jpg" alt="Descripción de la imagen" caption="Leyenda" >}}
```

## 4. Dónde guardar los archivos de imagen

Opción A — Directorio `static/` (recomendado para imágenes que no cambian):

```
blog/
├── static/
│   └── images/
│       ├── mi-imagen.jpg
│       └── diagrama.png
```

Referencia en el post:
```markdown
{{< figure src="/images/mi-imagen.jpg" caption="Mi imagen" >}}
```

Opción B — Page Bundle (carpeta junto al archivo `.md`):

```
content/
└── posts/
    └── mi-post/
        ├── index.md
        ├── imagen-1.jpg
        └── imagen-2.png
```

Referencia en el post:
```markdown
{{< figure src="imagen-1.jpg" caption="Imagen del post" >}}
```

Con page bundles también puedes usar `src="cover"` si nombraste la imagen de portada como `cover.*` en la misma carpeta.

## 5. Flujo de trabajo completo

1. **Crear el post:**
   ```bash
   ./blog.sh nuevo "Título del Post"
   ```

2. **Editar el archivo** en `content/posts/titulo-del-post.md`:
   - Completa el front matter
   - Escribe el contenido en Markdown
   - Inserta imágenes con los shortcodes `figure` o `pin`

3. **Previsualizar localmente** (opcional):
   ```bash
   hugo server
   ```
   Abre `http://localhost:1313` en tu navegador.

4. **Publicar:**
   ```bash
   ./blog.sh publicar
   ```
   Esto hace commit y push a GitHub. El blog se despliega automáticamente en `https://gerardo-alcazar.github.io/blog/`.

## 6. Ejemplo completo de post

```markdown
+++
date = '2026-07-27'
draft = true
title = 'Cómo añadir imágenes a tus posts'
description = 'Guía sobre cómo insertar imágenes en posts de Hugo con el tema brewm'
author = 'Gerardo Alcazar'
tags = ['hugo', 'imágenes', 'tutorial']
categories = ['guías']
cover = '/images/cover-example.jpg'
alt = 'Ejemplo de imagen de portada'
+++

## Introducción

Este post muestra cómo usar el shortcode `figure` para añadir imágenes.

{{< figure src="/images/demo.jpg" alt="Imagen de demostración" caption="Una imagen de ejemplo" >}}

## Layout completo

Puedes usar diferentes tipos de layout:

{{< figure src="/images/full-demo.jpg" caption="Imagen a pantalla completa" type="full" >}}

## Galería tipo Pinterest

{{< pin img="/images/thumb1.jpg" url="/posts/post-1" label="Post 1" >}}
{{< pin img="/images/thumb2.jpg" url="/posts/post-2" label="Post 2" >}}
{{< pin img="/images/thumb3.jpg" url="/posts/post-3" label="Post 3" >}}
```

## 7. Atajos y convenciones

- Los nombres de archivo deben ser en minúsculas y usar guiones (`mi-imagen.jpg`)
- Siempre añade `alt` a las imágenes para accesibilidad
- Usa `draft = true` mientras escribes y cámbialo a `false` al publicar
- Las imágenes en `static/` se sirven directamente; las en page bundles se optimizan automáticamente por Hugo