import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["template", "container", "pestSelect"]

  initialize() {
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
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.containerTarget.insertAdjacentHTML('beforeend', content);
  }

  filterPests(e) {
    let crop_id = $(e.target).children("option:selected").val();
    let pestSelect = $(e.target).parents('.form-group').first().next().find('.row.mt-2 .col-lg-12 #pest_id');
    console.log($(e.target).parents('.form-group').first().next().find('.row.mt-2 .col-lg-12 #pest_id'));
    console.log("filtering");
    $.ajax({
      type: 'GET',
      url: `/crops/${crop_id}/get_pests`,
      success: (data) => {
        console.log(data);
        for(let option of data) {
          pestSelect.append('<option value="' + option.id + '">' + option.name + '</option>');
        }
      },
      error: (xhr) => {
        console.log(xhr);
      }
    })
  }

  showDoseFields(e) {
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

  createTreatments() {
    // console.log("create");
    // console.log(containerTarget);
  }
} 
