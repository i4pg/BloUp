const fileInput = document.querySelector('#Upload input[type=file]');
fileInput.onchange = () => {
  if (fileInput.files.length > 0) {
    const fileName = document.querySelector('#Upload .file-name');
    fileName.textContent = fileInput.files[0].name;
  }
}
