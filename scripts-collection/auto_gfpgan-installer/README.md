# GFPGAN Automated Installer

<p align="center">
<img src="assets/script_welcome.png" width=150% height=150%>
<br/><br/>
<img src="https://github.com/TencentARC/GFPGAN/blob/master/assets/gfpgan_logo.png" width=30% height=30%>
</p>

> [!WARNING]  
> Due to an upstream problem with basicsr: [https://github.com/XPixelGroup/BasicSR/pull/667/](https://github.com/XPixelGroup/BasicSR/pull/667/commits/a6216bde14eaf5122528a9fd17eddd1c120f2b23) 
> Which seems to not have been fixed yet.
> So to manually adress this issue, after my script finishes installing, plase open the explorer visit the following path: `%localappdata%\Programs\Python\Python311\Scripts` Attention, your second python Folder may be named differently, so adapt this as needed.
> After this open the file `degradations.py` via right-click, `edit with notepad`, then reaplce the line: `from torchvision.transforms.functional_tensor import rgb_to_grayscale` with `from torchvision.transforms.functional import rgb_to_grayscale`
> This will resolve the issue.

Welcome to the GFPGAN Automated Installer repository! This batch script simplifies the installation process for GFPGAN, a powerful image-to-image translation tool, so that you don't have to run any complex commands manually. With this script, you can effortlessly set up GFPGAN on your system with optional NVIDIA GPU support and a user-friendly interface.

Please check out the awesome [GFPGAN](https://github.com/TencentARC/GFPGAN/) project and give them a star, they deserve it!

## Features

- **Automatic Installation:** Say goodbye to manual installations! This script automates the GFPGAN installation process, saving you time and effort.

- **NVIDIA GPU Support:** If you have an NVIDIA GPU, you can choose to enable CUDA support for faster processing. The script detects your GPU and configures GFPGAN accordingly.

- **User-Friendly Interface:** Enjoy a hassle-free experience with a user-friendly interface. No need to deal with complex commands or configuration files.

- **Colorful Output:** The script provides colorful output, making the installation process visually appealing and easy to follow.

- **Check the Code:** Due to the script being a batch file you can just right-click the file and select "Edit" to review the code by yourself.


## Prerequisites

Before running the script, make sure you have the following prerequisites in place:

- A Windows-based system.
- Administrator rights
- [NVIDIA GPU](https://www.nvidia.com/en-us/geforce/) (optional for GPU support).

## Usage

1. Clone or download this repository to your local machine.

2. Open a command prompt or PowerShell window and navigate to the repository directory.

3. Run the `auto_gfpgan-installer.bat` script by double-clicking it or executing it from the command line.

4. Follow the on-screen instructions to complete the installation. You can choose whether to enable NVIDIA GPU support during the installation process.

5. Once the installation is complete, you're ready to use GFPGAN!


## License

This project is licensed under the [MIT License](LICENSE).


