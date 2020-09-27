import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["template", "container", "pestSelect", "treatmentType"]

  initialize() {
    this.crop_id = null
    let crops = []
    $.ajax({
      type: 'GET',
      url: `/crops/get_crops`,
      success: (data) => {
        // console.log(data);
      },
      error: (xhr, textStatus, errorThrown) => {
        console.log(xhr);
        
      }
    })
  }
  
  appendForm(e) {
    e.preventDefault();
    console.log(document.getElementById('treatments-form'));
    let form = new FormData($('#treatments-form')[0])
    console.log(form.values());
    console.log(form.entries());
    console.log(form.values());
    console.log(form);
    window.form = form
    // var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    // this.containerTarget.insertAdjacentHTML('beforeend', content);
  }

  filterPests(e) {
    console.log("kjjjgjjj")
    let parent = $(e.target).parents('.form-group').first().after(html);
    $(e.target).prop('disabled', 'disabled')
    console.log(parent);
    // let crop_id = $(e.target).children("option:selected").val();
    // let treatbleTypeSelect = $(e.target).parents('.form-group').first().next().find('.row.mt-2 .col-lg-12 #pest_id');
    // console.log($(e.target).parents('.form-group').first().next().find('.row.mt-2 .col-lg-12 #pest_id'));
    // console.log("filtering");
    // $.ajax({
    //   type: 'GET',
    //   url: `/crops/${crop_id}/get_pests`,
    //   success: (data) => {
    //     console.log(data);
    //     for(let option of data) {
    //       treatbleTypeSelect.append('<option value="' + option.id + '">' + option.name + '</option>');
    //     }
    //   },
    //   error: (xhr) => {
    //     console.log(xhr);
    //   }
    // })
  }

  appendTreatableType() {
  }

  enabledTypeSelect(e) {
    // console.log("crop_id: ", $(e.target).children("option:selected").val())
    // console.log("class crop_id: ", typeof $(e.target).children("option:selected").val())
    if ($(e.target).children("option:selected").val() === "") {
      $(this.treatmentTypeTarget).prop('disabled', 'disabled');  
      return;
    }
    this.crop_id = $(e.target).children("option:selected").val()
    // console.log("tipo: ", $(this.treatmentTypeTarget).children("option:selected").val());
    $(this.treatmentTypeTarget).prop('disabled', false);
    if ($(this.treatmentTypeTarget).children("option:selected").val() != "") {
      // console.log("fjjfjjjjj")
      let action = $(this.treatmentTypeTarget).children("option:selected").val() === "Pest" ? 'get_pests' : 'get_deseases'
      let url = `/crops/${this.crop_id}/${action}`
      let title = $(this.treatmentTypeTarget).children("option:selected").val() + "s"
      console.log($(e.target).parents('.form-group').first().next().next().find('#treatable_id'))
      let treatbleTypeSelect = $(e.target).parents('.form-group').first().next().next().find('#treatable_id')
      this.getTreatbleTypes(url, treatbleTypeSelect, title)
    }
  }

  getTreatbleTypes(url, treatbleTypeSelect, title) {
    console.log(treatbleTypeSelect.parents('.form-group').first().find('.s-14.ml-1'))
    treatbleTypeSelect.parents('.form-group').first().find('.s-14.ml-1').html(title)
    $.ajax({
      type: 'GET',
      url: url,
      success: (data) => {
        console.log(data);
        treatbleTypeSelect.empty();
        treatbleTypeSelect.append('<option value="">Selecciona Plaga</option>');
        for(let option of data) {
          treatbleTypeSelect.append('<option value="' + option.id + '">' + option.name + '</option>');
        }
      },
      error: (xhr) => {
        console.log(xhr);
      }
    })
  }

  filterTreatableType(e) {
    let treatableType = $(this.treatmentTypeTarget).children("option:selected").val();
    let treatbleTypeSelect = $(e.target).parents('.form-group').first().next().find('#treatable_id')
    let action = treatableType === 'Desease' ? 'get_deseases' : 'get_pests';
    let url = `/crops/${this.crop_id}/${action}` 
    let title = treatableType + "s"
    console.log(url)
    this.getTreatbleTypes(url, treatbleTypeSelect, title)
  }

  showDoseFields(e) {
    let html = `

    `
    $(html).insertAfter($(e.target).parent().parent());
  }

  createTreatments() {
    // console.log("create");
    // console.log(containerTarget);
  }
} 
