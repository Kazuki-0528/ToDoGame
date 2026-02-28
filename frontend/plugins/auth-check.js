import firebase from "@/plugins/firebase"
import axios from "@/plugins/axios"

const authCheck = ({ store }) => {
  firebase.auth().onAuthStateChanged(async user => {
    if (user) {
      try {
        const { data } = await axios.get(`/v1/users?uid=${user.uid}`)
        if (data && data.user) {
          store.commit("setUser", data)
          return
        }
      } catch (error) {
        if (!error.response || error.response.status !== 404) {
          console.log(error)
        }
      }
    }

    store.commit("setUser", null)
  })
}

export default authCheck
