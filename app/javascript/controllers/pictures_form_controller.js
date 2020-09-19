import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["picture", "pictureAddButton"]
  initialize() {
    console.log(this.pictureTarget);
    console.log(this.pictureAddButtonTarget);
    this.modifyIcon()
  }

  modifyIcon() {
    let parent = this.pictureTarget.parentElement;
    let submitIcon = parent.querySelector('.submit-icon')
    let label = document.createElement('label');
    label.className += "btn btn-sm btn-outline-info btn-upload";
    label.innerHTML = `Agregar Nueva Foto`
    label.append(this.pictureTarget);
    console.log(label);
    $(parent).empty();
    parent.append(label);
    parent.append(submitIcon);
    console.log(parent);

  }

  showForm() {
    this.pictureAddButtonTarget.parentElement.style.display = 'none'
    console.log($('.form-picture-container'));
    document.querySelector('.form-picture-container').classList.remove("hidden-form");
  }
}

