import { Controller } from 'stimulus'
import SlimSelect from 'slim-select'

export default class extends Controller{
	static targets = ["links", "template"]

	connect(){
	}

	add_association(event){
		event.preventDefault()

		var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
		this.linksTarget.insertAdjacentHTML('beforebegin', content)
		this.initSelects(content)
	}

	remove_association(event){
		event.preventDefault()
		let wrapper = event.target.closest(".nested-fields")
		if (wrapper.dataset.newRecord == "true" ){
			wrapper.remove()
		}else{
			wrapper.querySelector("input[name*='_destroy']").value = 1
			wrapper.style.display = "none"
		}			
	}

	initSelects(content){
		let selects = $(content).find("select")
		const ids = selects.map(el => el.class);

		if (selects.length == 0){ return false }
		for (var i=0, max=selects.length; i < max; i++) {
			new SlimSelect({select: $(selects[i]) })
		}
	}
}