import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["categoryId", "code"]
  
  generateCode(e) {
    e.preventDefault();
    let id = $(this.categoryIdTarget).children("option:selected").val()
    $.ajax({
      type: 'GET',
      url: `/categories/${id}/get_supplies_codes`,
      success: (data) => {
        console.log(data);
        if(data.codes.length === 0) {
          this.generateInitialCategoryCode(data)
        } else {
          this.generateNextCategoryCode(data)
        }
      },
      error: (xhr, textStatus, errorThrown) => {
        console.log(xhr);
        
      }
    })
  }

  generateInitialCategoryCode({ category}) {
    this.codeTarget.value = category.toUpperCase().slice(0, 3).concat('-001');;
  }

  generateNextCategoryCode({ codes, category }) {
    let arr_max = Array(1000).fill().map((v, i) => i +1);
    let numbers = codes.map(code => code.slice(code.split('').lastIndexOf('-') + 1, code.split('').length)).sort((a, b) => a - b).map(num => Math.abs(num));
    let lastCodeNumber = ''
    console.log(numbers);
    for(let number of arr_max) {
      if (numbers.indexOf(number) === -1) {
        console.log(number);
        lastCodeNumber = number;
        break
      }
    }
    
    let nextNum = Math.abs(lastCodeNumber);
    if (String(nextNum).split('').length == 1) {
      this.calculateCodeValue("-00", nextNum, category)
    } else {
      this.calculateCodeValue("-0", nextNum, category)
    }
  }
  
  calculateCodeValue(ceros, nextNum, category){
    let arr = String(nextNum).split('')
    arr.unshift(ceros)
    this.codeTarget.value = category.toUpperCase().slice(0, 3).concat(arr.join(""));
  }
} 