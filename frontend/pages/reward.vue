<template>
  <v-container class="user-page" v-if="currentUser">
    <Status />
    <v-row justify="center">
      <v-col class="pb-0" cols="12" xs="12" sm="12" md="12" lg="8">
        <div class="parent">
          <img class="child" src="../assets/mon_285.gif" />
          <p class="child">コインを使って報酬をもらおう</p>
          <img class="child" src="../assets/mon_274.gif" @load="show=true" :class="{hide: !show}" />
          <AddReward @submit="addReward" />
        </div>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <RewardList :rewards="currentUser.rewards"/>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AddReward from "@/components/AddReward";
import RewardList from "@/components/RewardList";
import Status from "@/components/Status";
import axios from "@/plugins/axios";
import firebase from "@/plugins/firebase";
export default {
  data() {
    return {
      email: "",
      name: "",
      level: "",
      point: "",
      experience_point: "",
      show1: false,
      show2: false,
      error: "",
      showContent: false
    };
  },
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        if (!newUser) {
          return redirect("/login");
        }
      }
    );
  },
  components: {
    AddReward,
    RewardList,
    Status
  },
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async addReward(reward) {
      try {
        const { data } = await axios.post("/v1/rewards", {
          reward
        });
        const userReward = this.currentUser.reward ? this.currentUser.rewards : [];
        this.$store.commit("setUser", {
          ...this.currentUser,
          rewards: [...userReward, data]
        });
        this.$store.commit("clearErrors");
      } catch (error) {
        console.log("UserPage: 110", error);
        const { data } = error.response;
        this.$store.commit("setError", data.error_msg);
      }
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;
$accent-color: red;

$pc: 1024px;
$tab: 680px;
$sp: 480px;

@mixin pc {
  @media (max-width: ($pc)) {
    @content;
  }
}

@mixin tab {
  @media (max-width: ($tab)) {
    @content;
  }
}
@mixin sp {
  @media (max-width: ($sp)) {
    @content;
  }
}

@font-face {
  font-family: dot;
  src: url("../assets/fonts/k8x12S.ttf") format("truetype");
}

.user-page {
  .user-status {
    @include pc {
      width: 100%;
    }
    @include tab {
      width: 100% !important;
    }
    @include sp {
      width: 100% !important;
    }
  }
  .parent {
    text-align: center;
    .child {
      opacity: 1;
      transition: opacity 1s;
      display: inline-block;
      font-family: dot;
      letter-spacing: 10px;
      font-size: 30px;
      color: $main-color;
      vertical-align: middle;
      p {
        font-weight: bold;
      }
    }
    .child.hide {
      opacity: 0;
    }
  }
}
</style>
