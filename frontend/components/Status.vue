<template>
  <v-container class="user-page" v-if="currentUser">
    <v-row class="user-status">
      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p>名前：{{ currentUser.user.name }}</p>

        <div class="user-point">
          <v-icon big color="yellow">monetization_on</v-icon>
          <p class="user-task-point">{{ currentUser.user.point }}コイン</p>
        </div>
      </v-col>

      <v-col cols="12" xs="6" sm="6" md="6" lg="6">
        <p class="user-level">ステータス:{{ currentUser.user.status }}</p>
        <p>残りの体力</p>
        <v-rating
          v-model="rating"
          color="red darken-3"
          background-color="grey darken-1"
          :empty-icon="emptyIcon"
          :full-icon="fullIcon"
          hover
        ></v-rating>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      show1: false,
      show2: false,
      error: "",
      showContent: false,
      rating: 0,
      emptyIcon: 'mdi-heart-outline',
      fullIcon: 'mdi-heart',
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
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    }
  },
  methods: {}
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;

.user-status {
  border: 2px white solid;
  margin: 0 auto;
  width: 66%;
  background-color: $main-color;
}

.user-point {
  display: flex;
  .v-icon {
    width: 10%;
    height: 10%;
    padding-top: 5px;
    display: inline-block;
  }
  .user-task-point {
    display: inline-block;
    font-size: x-large;
    color: blue;
    padding-left: 3%;
  }
}

h2 {
  text-align: center;
  color: $sub-color;
}
</style>
