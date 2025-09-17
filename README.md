# Rembg-Docker-Image

A lightweight Docker image for [Rembg](https://github.com/danielgatis/rembg), a tool to remove image backgrounds using deep learning.  
This containerized setup ensures you can use `rembg` without installing Python or dependencies directly on your machine.

## Build the image
Clone this repository and build the Docker image:

```powershell
docker build -t rembg:cpu ./
```

## Usage
Process an image with Rembg:

```powershell
docker run --rm -v "${PWD}:/app" rembg:cpu i input.png output.png
```

- `--rm` → automatically removes the container after it finishes.
- `-v "${PWD}:/app"` → mounts your current directory into the container at `/app`.
- `i` → the `rembg` subcommand for processing a single file.
- `input.png` → source image (in your current directory).
- `output.png` → result saved in the same directory.

## Tips
- These commands are for PowerShell on Windows. Adjust them accordingly for other shells/operating systems. They should be similar.
- These instructions assume you have Docker installed. You can install it [here](https://docs.docker.com/get-docker/) if you don't have it.
- Remove the `--rm` flag if you want to keep the so it doesn’t need to be recreated each time (e.g. for multiple uses).
- Run `rembg --help` inside the container for other available subcommands:
    <br><br>
    ```powershell
    docker run rembg:cpu --help
    ```

## GPU Support
If you have a supported GPU, you can build an image with GPU acceleration for much faster background removal.

1. Check if your GPU is supported by onnxruntime in their [installation matrix](https://onnxruntime.ai/docs/execution-providers/).
2. Update the Dockerfile to install the GPU variant instead of CPU:
    ```powershell
    RUN pip install --no-cache-dir "rembg[gpu,cli]"
    ```

3. When running, make sure Docker has GPU access. With NVIDIA Docker (via CUDA Toolkit + nvidia-container-toolkit):
    ```powershell
    docker run --rm --gpus all -v "${PWD}:/app" rembg:gpu i input.png output.png
    ```

4. Notes:
    - NVIDIA GPUs may require `onnxruntime-gpu`, `cuda`, and `cudnn-devel`.
    - If `rembg[gpu]` doesn’t work, fall back to `rembg[cpu]`.
    - For AMD GPUs, install `onnxruntime-rocm` and use:
    <br><br>
        ```powershell
        RUN pip install --no-cache-dir "rembg[rocm,cli]"
        ```
    This should—in theory—work, but I didn't test it myself as I didn't really need the GPU's tremendous power for my use case.
    I recommend you visit the [Rembg repository](https://github.com/danielgatis/rembg) if you face any issues.