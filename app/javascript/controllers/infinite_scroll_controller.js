import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["entries", "pagination"]

    scroll() {
       let url = this.paginationTarget.querySelector("a[rel='next']").href

       const body = document.body,
           html = document.documentElement

       const height = Math.max(
           body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight
       )
       if (window.pageYOffset >= height - window.innerHeight -100) {
          this.loadMore(url)
       }
    }
    loadMore(url) {
        Rails.ajax({
            type: 'GET',
            url: url,
            dataType: 'json',
            success: (data) => {
                this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
                this.paginationTarget.innerHTML = data.pagination
            }
        })
    }
}