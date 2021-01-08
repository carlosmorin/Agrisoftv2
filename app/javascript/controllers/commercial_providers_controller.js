import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
const Axios = require('axios');

export default class extends Controller {
  static targets = [ "categorySelect", 'fiscalDataContainer' ]


  initialize() {
    $("#addresses")
      .on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
        console.log("after-insert")
        let selects = $(insertedItem).find("select")
        for (var i = 0, max=selects.length; i < max; i++) {
          new SlimSelect({select: `#${$(selects[i]).attr("id")}`})
        }
      })
  }

  getSubcategories(e){
    var categoryId = e.currentTarget.value
    var subcategoriesSelect = $('select#provider_subcategory_id')
    subcategoriesSelect.empty()
    var url = `/commercial/config/provider_categories/${categoryId}/get_subcategories`
    var options = "<option value=''>SELECCIONA</option>";

    Axios({
      method: 'GET',
      url: url
    })
    .then(function (response) {
      for (var key in response.data){
        options += "<option value='"+ response.data[key].id +"'>" + response.data[key].name +  "</option>";
      }
      subcategoriesSelect.append(options);
    });
  }

  toggleFiscalData(e){
    if (e.currentTarget.checked) {
      this.fiscalDataContainerTarget.classList.remove("d-none")
    }else{
      this.fiscalDataContainerTarget.classList.add("d-none")
    }
  }

}
