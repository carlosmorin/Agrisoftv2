import { Controller } from "stimulus"
const Inputmask = require('inputmask');

export default class extends Controller {
	initialize(){
		var phone_input = document.getElementsByClassName("phone_mask");
		var phone_mask = new Inputmask({"mask": "(999) 999-9999"});
		phone_mask.mask(phone_input);

		var phone_mask_ext_input = document.getElementsByClassName("phone_mask_ext");
		var phone_mask_ext = new Inputmask({"mask": "(999) 999-9999  EXT: 9999"});
		phone_mask_ext.mask(phone_mask_ext_input);

		var cp_input = document.getElementsByClassName("cp_mask");
		var cp_mask = new Inputmask({"mask": "99999"});
		cp_mask.mask(cp_input);

		var porcent_input = document.getElementsByClassName("porcent_mask");
		var porcent_mask = new Inputmask({"mask": "99"});
		porcent_mask.mask(porcent_input);
	}
}
