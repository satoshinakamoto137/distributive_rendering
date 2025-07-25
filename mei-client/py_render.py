import subprocess
import sys

def render_url(url):
    try:
        print(f"🧠 Enviando a renderizar: {url}")
        subprocess.run(["./fetch-and-render.sh", url], check=True)
    except subprocess.CalledProcessError as e:
        print(f"❌ Error ejecutando el render: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("⚠️  Debes pasar la URL como argumento.")
        print("👉 Ejemplo: python py_render.py https://tenmei.tech")
        sys.exit(1)

    url = sys.argv[1]
    render_url(url)
