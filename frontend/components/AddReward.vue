<template>
  <v-form>
    <v-row class="add-reward">
      <v-col class="pr-0" cols="3" xs="6" sm="2" md="2" lg="2">
        <span>なげる</span>
        <v-hover v-slot:default="{ hover }">
          <v-icon
            @click="getRandomNumber()"
            onclick="disabled = true"
            size="50px"
            color="red"
            v-text="hover ? 'mdi-cube-send' : 'mdi-dice-3-outline'"
          >
          </v-icon>
        </v-hover>
        <p class="point">
          {{ point }}
        </p>
        
      </v-col>
      <v-col class="pr-0" cols="9" xs="8" sm="8" md="8" lg="8">
        <v-text-field
          v-model="title"
          :counter="20"
          label="報酬"
          required
          outlined
        >
        </v-text-field>
      </v-col>
      <v-col class="pr-0" cols="12" xs="2" sm="2" md="2" lg="2">
        <v-btn class="reward-btn" @click="handleSubmit">
          登録
        </v-btn>
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
export default {
  props: ["reward"],
  data() {
    return {
      title: "",
      point: "",
    };
  },
  methods: {
    handleSubmit() {
      const reward = {
        title: this.title,
        point: this.point,
        user_id: this.$store.state.currentUser.user.id,
      };
      this.$emit("submit", reward);
      this.title = "";
      this.point = "";
    },
    getRandomNumber() {
      const randnum = Math.floor( Math.random() * 21 );
      this.point = randnum;
    }
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;

@font-face {
  font-family: dot;
  src: url("../assets/fonts/k8x12S.ttf") format("truetype");
}

@mixin btn {
  background-color: white;
  border: 2px solid white;
  color: white;
  display: inline-block;
  font-weight: bold;
  margin: 15px;
  width: 93%;
}
.point {
  color: red;
}

span {
  font-family: dot;
  letter-spacing: 5px;
}

.add-reward {
  .reward-btn {
    @include btn;
    &:hover {
      border: 2px solid blue;
      color: rgba(8, 113, 233, 0.884);
    }
  }
}
</style>
