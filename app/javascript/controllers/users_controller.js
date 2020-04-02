import { Controller } from "stimulus"
const axios = require('axios');
const toastr = require('toastr');
const Swal = require('sweetalert2')
const Toast = Swal.mixin({
      toast: true,
      position: 'top-start',
      showConfirmButton: false,
      timer: 3000
    });
const swalWithBootstrapButtons = Swal.mixin({
  customClass: {
    confirmButton: 'btn btn-dark-blue btn-sm mr-2',
    cancelButton: 'btn btn-sm btn-default'
  },
  buttonsStyling: false
})

export default class extends Controller {
	initialize(){
		$(".erasable > input").keyup(function () {
			if($(this).val().length >= 2){
				$(".erasable > span").removeClass("d-none");
			}else{
				$(".erasable > span").addClass("d-none");
			}
		})

		$(".erasable > span").click(function () {
			$(this).siblings("input").val("");
			$(this).addClass("d-none");
		})

		$("[data-behavior='delete']").click( function (e) {
   	 	e.preventDefault()
   	 	var column =  $(this).parent().parent();
   	 	var url = $(this).attr("href");
   	 	var title = "<h4 class='s-18 bold pb-0 c-blue'>Esta seguro?</h4>";
   	 	var desc = "<p4 class='s-14'>Los cambios no podrán ser revertidos!</p>";
	   	swalWithBootstrapButtons.fire({
			  title: title,
			  html:  desc,
			  icon: false,
			  showCancelButton: true,
			  width: '300px',
			  animation: false,
			  confirmButtonText: 'Confirmar!',
			  cancelButtonText: 'Cancelar',
			}).then((result) => {
			  if (result.value) {
			  	axios({
			  		method: 'DELETE',
						dataType: "JSON",
					  url: url,
					  data: { authenticity_token: $('[name="csrf-token"]')[0].content},
					})
					.then(function (response) {
						column.fadeOut('fast');
					  toastr.options.preventDuplicates = true;
						toastr.options.closeButton = true;
						toastr.success('Usuario eliminado con exito', {timeOut: 2000})
					});
			  }
			})
	  });

	}

	openModal() {
		$(".modal-body").empty()
		$('#modal-window').modal('show')
	}

	sendForm(event){
		event.preventDefault(); 
		var form = $("#new_user")
    var url = form.attr('action');
    $.ajax({
      type: "POST",
      url: url,
      data: form.serialize(),
      success: function(data){
        toastr.options.preventDuplicates = true;
				toastr.options.closeButton = true;
				toastr.success('Usuario registrado con exito', {timeOut: 2000})
				$('#modal-window').modal('hide')
      },
      error: function(xhr, textStatus, errorThrown) {
        var response = xhr.responseJSON;
				var validations = "<ul class='pl-2 mb-1'>";        
        for(var key in response)
				{
					validations += "<li class='s-12'>" + response[key][0] + "</li>";
				}
				validations += "</ul>";        
				$(".callout-danger").removeClass("d-none").empty().html(validations)
        return false;
      }
    });
		
	}

	edit(){
		event.preventDefault(); 
		var form = $("form.edit_user")
    var url = form.attr('action');
    $.ajax({
      type: "PATCH",
      url: url,
      data: form.serialize(),
      success: function(data){
        toastr.options.preventDuplicates = true;
				toastr.options.closeButton = true;
				toastr.success('Usuario actualizado con exito', {timeOut: 2000})
				$('#modal-window').modal('hide')
      },
      error: function(xhr, textStatus, errorThrown) {
        var response = xhr.responseJSON;
				var validations = "<ul class='pl-2 mb-1'>";        
        for(var key in response)
				{
					validations += "<li class='s-12'>" + response[key][0] + "</li>";
				}
				validations += "</ul>";        
				$(".callout-danger").removeClass("d-none").empty().html(validations)
        return false;
      }
    });
	}

}

