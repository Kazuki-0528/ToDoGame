import firebase from "@/plugins/firebase";
import axios from "@/plugins/axios";

const authCheck = ({ store, redirect }) => {
  firebase.auth().onAuthStateChanged(async (user) => {
    if (!user) {
      store.commit("setUser", null);
      return;
    }

    try {
      const { data } = await axios.get(`/v1/users?uid=${user.uid}`);
      if (data && data.user) {
        store.commit("setUser", data);
      }
      return;
    } catch (error) {
      if (!error.response || error.response.status !== 404) {
        console.log(error);
        store.commit("setUser", null);
        return;
      }
    }

    try {
      const { data: createdUser } = await axios.post("/v1/users", {
        user: {
          email: user.email,
          uid: user.uid,
          name: user.displayName || "ゲスト",
        },
      });
      store.commit("setUser", {
        user: createdUser,
        todos: [],
        rewards: [],
      });
    } catch (error) {
      console.log(error);
      store.commit("setUser", null);
    }
  });
};

export default authCheck;
