import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    "treatmentType", "cropSelect", 
    "recommendedDose", "foliarQuantity", 
    "foliarUnit", "irrigationQuantity",
    "irrigationUnit"
  ]

  initialize() {
    console.log(this.foliarQuantityTarget)
    $(this.foliarQuantityTarget).prop("disabled", true);
    $(this.foliarUnitTarget).prop("disabled", true);
    $(this.irrigationQuantityTarget).prop("disabled", true);
    $(this.irrigationUnitTarget).prop("disabled", true);
    // console.log(this.formGroupTarget)
    // $(this.foliarQuantityTarget)
    // $(this.formGroupTarget).addClass("d-none")
    this.crop_id = null
    // console.log($('select'))
    // let crops = []
    // $.ajax({
    //   type: 'GET',
    //   url: `/crops/get_crops`,
    //   success: (data) => {
    //     // console.log(data);
    //   },
    //   error: (xhr, textStatus, errorThrown) => {
    //     console.log(xhr);
        
    //   }
    // })
  }

  showTreatmentsForm(e) {
    e.preventDefault();
    console.log("jfjf")
    $(this.formGroupTarget).removeClass("d-none")
  }

  enabledTypeSelect(e) {
    let dataTreatbleType = $(e.target).parents('.form-group').first().next().find('.data_treatable_type')
    console.log(dataTreatbleType)
    if ($(e.target).children("option:selected").val() === "") {
      dataTreatbleType.prop('disabled', 'disabled');
      return;
    }
    this.crop_id = $(e.target).children("option:selected").val()
    $(e.target).parents('.form-group').first().next().find('.data_treatable_type').prop('disabled', false)
    if (dataTreatbleType.children("option:selected").val() != "") {
      let action = dataTreatbleType.children("option:selected").val() === "Pest" ? 'get_pests' : 'get_deseases'
      let url = `/crops/${this.crop_id}/${action}`
      let title = dataTreatbleType.children("option:selected").val() + "s"
      let treatbleTypeSelect = $(e.target).parents('.form-group').first().next().next().find('.data_treatable_id')
      this.getTreatbleTypes(url, treatbleTypeSelect, title)
    }
  }

  getTreatbleTypes(url, treatbleTypeSelect, title) {
    treatbleTypeSelect.parents('.form-group').first().find('.s-14.ml-1').html(title)
    $.ajax({
      type: 'GET',
      url: url,
      success: (data) => {
        console.log(data);
        treatbleTypeSelect.empty();
        treatbleTypeSelect.append('<option value="">Selecciona</option>');
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
    let treatableType = $(e.target).children("option:selected").val();
    let treatbleTypeSelect = $(e.target).parents('.form-group').first().next().find('.data_treatable_id')
    let action = treatableType === 'Desease' ? 'get_deseases' : 'get_pests';
    let url = `/crops/${this.crop_id}/${action}` 
    let title = treatableType + "s"
    this.getTreatbleTypes(url, treatbleTypeSelect, title)
  }

  enableSuppliesSelect() {
    $(this.supplySelectTarget).prop('disabled', false);
  }

  enabledInputs() {
    $(this.foliarQuantityTarget).prop("disabled", false);
    $(this.foliarUnitTarget).prop("disabled", false);
    $(this.irrigationQuantityTarget).prop("disabled", false);
    $(this.irrigationUnitTarget).prop("disabled", false);
  }

  showRecommendedDoses(e) {
    // let firstChild = $(e.target).parents('.col-md-6').first().next().next()
    // let id = firstChild.find('textarea').attr('name').split(']')[1].slice(1)
    // console.log(id);
    // let html = `
    //     <div class="col-lg-12">
    //       <h6>Dosis recomendada</h6>
    //       <b>Foliar</b>
    //       <div class="row">
    //         <div class="col-lg-6">
    //           <div class="form-group">
    //             <label>Cantidad</label>
    //             <input class="form-control form-control-sm" id="foliar_quantity" name="treatment[treatment_supplies_attributes][${id}][recommended_doses][foliar][foliar_quantity]" type="number">
    //           </div>
    //         </div>
    //         <div class="col-lg-6">
    //           <div class="form-group">
    //             <label>Unidad</label>
    //             <input class="form-control form-control-sm" id="foliar_unit" name="treatment[treatment_supplies_attributes][${id}][recommended_doses][foliar][foliar_unit]">
    //           </div>
    //         </div>
    //       </div>
    //       <b>Riego</b>
    //       <div class="row">
    //         <div class="col-lg-6">
    //           <div class="form-group">
    //             <label>Cantidad</label>
    //             <input class="form-control form-control-sm" id="irrigation_quantity" name="treatment[treatment_supplies_attributes][${id}][recommended_doses][irrigation][irrigation_quantity]" type="number">
    //           </div>
    //         </div>
    //         <div class="col-lg-6">
    //           <div class="form-group">
    //             <label>Unidad</label>
    //             <input class="form-control form-control-sm" id="irrigation_unit" name="treatment[treatment_supplies_attributes][${id}][recommended_doses][irrigation][irrigation_unit]">
    //           </div>
    //         </div>
    //       </div>
    //     </div>
    // `

    // let container = $(e.target).parents('.row.mt-1').first().next()
    // console.log(container);
    // container.html(html)
  }
 
  createTreatments() {
    // console.log("create");
    // console.log(containerTarget);
  }
} 
