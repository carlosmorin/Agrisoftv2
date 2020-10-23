import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["picture", "pictureAddButton", "cancelButton"]

  initialize() {
    this.modifyIcon()
  }

  modifyIcon() {
    let parent = this.pictureTarget.parentElement;
    let submitIcon = parent.querySelector('.submit-icon')
    let cancelIcon = parent.querySelector('.cancel-icon')
    let label = document.createElement('label');
    label.className += "btn btn-sm btn-outline-info btn-upload";
    label.innerHTML = `<p class="m-0">Agregar Nueva Foto</p>`
    label.append(this.pictureTarget);
    $(parent).empty();
    this.addElements(parent, [label, cancelIcon])
    
    this.pictureTarget.addEventListener('change', (e) => {
      $(parent).empty();
      console.log("chagned");
      let inputFile = label.querySelector(['#pest_pictures', '#desease_pictures']);
      let fileName = e.srcElement.files[0].name
      $(inputFile).prev().replaceWith(`<p class="m-0">${fileName.slice(0,10).concat(fileName.slice(fileName.lastIndexOf('.')))}</p>`)
      this.addElements(parent, [label, submitIcon])
    })
  }

  showForm() {
    this.pictureAddButtonTarget.parentElement.classList.add("hidden-form");
    $('.form-picture-container').removeClass('hidden-form')
  }

  resetForm() {
    this.pictureAddButtonTarget.parentElement.classList.remove("hidden-form");
    $('.form-picture-container').addClass('hidden-form');
  }

  addElements(parent, elements) {
    for(let element of elements) {
      parent.append(element)
    }
  }
}

