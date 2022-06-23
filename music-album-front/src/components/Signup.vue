<template>
  <div>
    <section class="h-screen">
      <div class="container px-6 py-12 h-full">
        <div class="flex justify-center items-center flex-wrap h-full g-6 text-gray-800">
          <div class="md:w-8/12 lg:w-6/12 mb-12 md:mb-0">
            <img
              src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg"
              class="w-full"
              alt="Phone image"
            />
          </div>
          <div class="md:w-8/12 lg:w-5/12 lg:ml-20">
            <h3 class="text-2xl mb-6 underline font-bold text-slate-600">Sign Up</h3>
            <form @submit.prevent="signup">
              <div class="mb-6">
                <input
                  type="text"
                  class="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                  placeholder="Email address"
                  v-model="email"
                />
              </div>
              <div class="mb-6">
                <input
                  type="password"
                  class="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                  placeholder="Password"
                  v-model="password"
                />
              </div>

              <div class="mb-6">
                <input
                  type="password"
                  class="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                  placeholder="Password Confirmation"
                  v-model="password_confirmation"
                />
              </div>

              <button
                type="submit"
                class="inline-block px-7 py-3 bg-blue-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out w-full"
                data-mdb-ripple="true"
                data-mdb-ripple-color="light"
              >
                Sign up
              </button>
              <div class="my-4">
                <router-link to="/" class="px-7 py-3 bg-blue-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out w-full">Sign In</router-link>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
  export default {
    name: 'Signup',
    data () {
      return {
        email: '',
        password: '',
        password_confirmation: '',
        error: ''
      }
    },
    created () {
      this.checkSignedIn()
    },
    updated () {
      this.checkSignedIn()
    },
    methods: {
      signin () {
        this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
          .then(response => this.signinSuccesFul(response))
          .catch(error => this.signinFailed(error))
      },
      signinSuccesFul (response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }

        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.error = ''
        this.$router.replace('/records')
      },
      signinFailed (error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something wrong'
        delete localStorage.csrf
        delete localStorage.signedIn
      },
      checkSignedIn () {
        if (localStorage.signedIn) {
          this.$router.replace('/records')
        }
      }
    }
  }
</script>
