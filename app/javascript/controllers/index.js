
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import SlimSelect from 'slim-select'

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

document.addEventListener("turbolinks:load", () => {
	new SlimSelect({
  	select: '.slim-select'
	})
})