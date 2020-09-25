import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["template", "container", "pestSelect"]
  // static targets = ["picture", "pictureAddButton", "cancelButton"]

  initialize() {
    let crops = []
    $.ajax({
      type: 'GET',
      url: `/crops/get_crops`,
      success: (data) => {
        console.log(data);
      },
      error: (xhr, textStatus, errorThrown) => {
        console.log(xhr);
        
      }
    })
  }
  
  appendForm(e) {
    e.preventDefault();
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    console.log(this.linksTarget);
    this.containerTarget.insertAdjacentHTML('beforeend', content);
    // console.log(e);
    // console.log("apending form")
    // let form = document.getElementById('treatments')
    // console.log(form);
    // let parent = document.getElementById('treatments').parentElement;
    // console.log(parent);
    // parent.appendChild(form);
    // console.log(parent);
    // let crop_id = $('#crop_id').children("option:selected").val();
    // console.log(crop_id);
  }

  filterPests(e) {
    let crop_id = $(e.target).children("option:selected").val();
    console.log($(e.target).parent().parent().parent().next().children().last().children().last());
    let pestSelect = $(e.target).parent().parent().parent().next().children().last().children().last().children().first()
    // .append('<option value="' + 2 + '">' + 'Name' + '</option>');
    console.log("filtering");
    $.ajax({
      type: 'GET',
      url: `/crops/${crop_id}/get_pests`,
      success: (data) => {
        console.log(data);
        for(let option of data) {
          pestSelect.append('<option value="' + option.id + '">' + option.name + '</option>');
        }
        // console.log(this.pestSelectTarget);
      },
      error: (xhr) => {
        console.log(xhr);
      }
    })
  }

  showDoseFields(e) {
    // console.log($(e.target).parent().parent().);
    // console.log("fields");
    let html = `
      <div class="col-lg-12 mt-4">
        <h6>Dosis recomendada</h6>
        <b>Foliar</b>
        <div class="row">
          <div class="col-lg-6">
            <div class="form-group">
              <label>Cantidad</label>
              <input name="foliar_quantity" type="number" class="form-control form-control-sm" id="foliar_quantity"/>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group">
              <label>Unidad</label>
              <input name="foliar_unit" class="form-control form-control-sm" id="foliar_unit"/>
            </div>
          </div>
        </div>
        <b>Riego</b>
        <div class="row">
          <div class="col-lg-6">
            <div class="form-group">
              <label>Cantidad</label>
              <input name="irrigation_quantity" type="number" class="form-control form-control-sm" id="irrigation_quantity"/>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group">
              <label>Unidad</label>
              <input name="irrigation_unit" class="form-control form-control-sm" id="irrigation_unit"/>
            </div>
          </div>
        </div>
      </div>
    `
    $(html).insertAfter($(e.target).parent().parent());
  }
} 
