<?php

namespace Database\Seeders;

use App\Models\BusStop;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BusStopSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        BusStop::factory()->createMany([
            ['latitude' => 8.98820, 'longitude' => 7.39454, 'name' => 'Chika'],
            ['latitude' => 8.99302, 'longitude' => 7.40207, 'name' => 'Aleta'],
            ['latitude' => 9.00663, 'longitude' => 7.41603, 'name' => 'Dantata bridge'],
            ['latitude' => 9.01430, 'longitude' => 7.42321, 'name' => 'Kuchingoro'],
            ['latitude' => 9.01887, 'longitude' => 7.42757, 'name' => 'Karmajiji'],
            ['latitude' => 9.02942, 'longitude' => 7.43925, 'name' => 'House on the rock'],
            ['latitude' => 9.05093, 'longitude' => 7.45423, 'name' => 'Finance bridge'],
            ['latitude' => 9.05461, 'longitude' => 7.45479, 'name' => 'Finance junction'],
            ['latitude' => 9.06623, 'longitude' => 7.45227, 'name' => 'Berger roundabout'],
            #
            ['latitude' => 9.07645, 'longitude' => 7.45539, 'name' => 'Mabushi'],
            ['latitude' => 9.07645, 'longitude' => 7.45539, 'name' => 'Mabushi bustop'],
            ['latitude' => 9.07645, 'longitude' => 7.45539, 'name' => 'Mabushi park'],
            ['latitude' => 9.08326, 'longitude' => 7.46352, 'name' => 'Banex under bridge'],
            ['latitude' => 9.09571, 'longitude' => 7.47554, 'name' => 'Nicon junction'],
            ['latitude' => 9.09571, 'longitude' => 7.47554, 'name' => 'Ministers hill'],
            ['latitude' => 9.11743, 'longitude' => 7.45474, 'name' => 'Katampe junction (by total energies)'],
            #
            ['latitude' => 9.10622, 'longitude' => 7.49093, 'name' => 'Mpape junction'],
            ['latitude' => 9.05061, 'longitude' => 7.52584, 'name' => 'Aya round about'],
            ['latitude' => 9.10622, 'longitude' => 7.49093, 'name' => 'Abacha baracks bustops'],
            ['latitude' => 9.10622, 'longitude' => 7.49093, 'name' => 'Kugbo furniture'],
            ['latitude' => 9.02248, 'longitude' => 7.56275, 'name' => 'Karu bridge'],
            ['latitude' => 9.02294, 'longitude' => 7.57027, 'name' => 'Nyanya before bridge'],
            ['latitude' => 9.01247, 'longitude' => 7.56275, 'name' => 'Checkpoint bustop'],
            ['latitude' => 9.01247, 'longitude' => 7.56275, 'name' => 'Abacha road bustop'],
            ['latitude' => 9.03023, 'longitude' => 7.58941, 'name' => 'Sharp corner'],
            ['latitude' => 9.03023, 'longitude' => 7.58941, 'name' => 'Mararaba bustop'],
            #
            ['latitude' => 9.02866, 'longitude' => 7.17472, 'name' => 'Anagada'],
            ['latitude' => 9.0556272, 'longitude' => 7.1924968, 'name' => 'Tungamaje'],
            ['latitude' => 9.08481, 'longitude' => 7.21615, 'name' => 'College of Education Zuba'],
            ['latitude' => 9.0904728, 'longitude' => 7.2183759, 'name' => 'Zuba Park'],
            #
            ['latitude' => 9.0940292, 'longitude' => 7.2243322, 'name' => 'Living Faith Junction'],
            ['latitude' => 9.10034, 'longitude' => 7.24362, 'name' => 'LEA Primary School'],
            ['latitude' => 9.1009953, 'longitude' => 7.2461630, 'name' => 'Dantata Junction'],
            ['latitude' => 9.1106597, 'longitude' => 7.2579198, 'name' => 'Dunamis Junction (Tunga Wakili)'],
            ['latitude' => 9.1130561, 'longitude' => 7.2601145, 'name' => 'Dei Dei Junction'],
            ['latitude' => 9.1281515, 'longitude' => 7.2743783, 'name' => 'Mopol Barrack'],
            ['latitude' => 9.1364595, 'longitude' => 7.2916013, 'name' => 'Kagini'],
            ['latitude' => 9.1376694, 'longitude' => 7.3004473, 'name' => 'Kagini Junction'],
            ['latitude' => 9.1396702, 'longitude' => 7.3142246, 'name' => 'NYSC Junction'],
            ['latitude' => 9.1410021, 'longitude' => 7.3237272, 'name' => 'NNPC Junction'],
            ['latitude' => 9.1437013, 'longitude' => 7.3441288, 'name' => 'Phase 3 Junction'],
            ['latitude' => 9.1390258, 'longitude' => 7.3516404, 'name' => 'Kubwa Under Bridge'],
            ['latitude' => 9.1305626, 'longitude' => 7.3652898, 'name' => 'Dutse Alhaji Junction'],
            ['latitude' => 9.1225724, 'longitude' => 7.3838346, 'name' => 'Dawaki'],
            #
            ['latitude' => 9.1222542, 'longitude' => 7.3875082, 'name' => 'Dawaki Modern Market Bridge'],
            ['latitude' => 9.1187324, 'longitude' => 7.4059718, 'name' => 'Rain Oil Filling Station'],
            ['latitude' => 9.1180203, 'longitude' => 7.4216070, 'name' => 'Setraco Gate'],
            ['latitude' => 9.0677687, 'longitude' => 7.4037310, 'name' => 'Life Camp Junction'],
            ['latitude' => 9.0678167, 'longitude' => 7.4016371, 'name' => 'Kado Fish Market'],
            ['latitude' => 9.0649202, 'longitude' => 7.3918993, 'name' => 'Agwan Cement Junction'],
            ['latitude' => 9.0662067, 'longitude' => 7.3838988, 'name' => 'Dape Bus Stop'],
            ['latitude' => 9.0661110, 'longitude' => 7.3709868, 'name' => 'Rain Oil Karmo'],
            #
            ['latitude' => 9.03337, 'longitude' => 7.46340, 'name' => 'Area One Roundabout'],
            ['latitude' => 9.03286, 'longitude' => 7.46362, 'name' => 'Area One Roundabout'],
            ['latitude' => 9.02928, 'longitude' => 7.46765, 'name' => 'Area One Roundabout Under Bridge'],
            ['latitude' => 9.0241164, 'longitude' => 7.4760059, 'name' => 'Area 3 Junction'],
            ['latitude' => 9.0206024, 'longitude' => 7.4813711, 'name' => 'Apo Bridge'],
            ['latitude' => 9.0130914, 'longitude' => 7.4914684, 'name' => 'Apo Roundabout'],
            ['latitude' => 9.0201839, 'longitude' => 7.4975990, 'name' => 'Guzape Junction (SARS Bus Stop)'],
            ['latitude' => 9.0274518, 'longitude' => 7.5022486, 'name' => 'CoZa'],
            ['latitude' => 9.0016557, 'longitude' => 7.4243847, 'name' => 'Galadima Roundabout'],
            ['latitude' => 8.9981598, 'longitude' => 7.4305069, 'name' => 'Sumcity Estate Junction'],
            ['latitude' => 8.9862287, 'longitude' => 7.4474526, 'name' => 'Sunny Vale Estate Junction'],
            ['latitude' => 8.9799421, 'longitude' => 7.4569089, 'name' => 'EFAB Junction (Lokogoma)'],
            ['latitude' => 8.9791293, 'longitude' => 7.4631383, 'name' => 'Lokogoma Junction'],
            ['latitude' => 8.9743238, 'longitude' => 7.4864155, 'name' => 'Wumba Junction'],
            ['latitude' => 8.9736234, 'longitude' => 7.4957288, 'name' => 'Kabusa Junction'],
            ['latitude' => 8.9468780, 'longitude' => 7.4942275, 'name' => 'Apo Primary School Junction'],
            ['latitude' => 8.9279999, 'longitude' => 7.4888800, 'name' => 'Waru Junction'],
            ['latitude' => 8.9972005, 'longitude' => 7.4890269, 'name' => 'NEPA Junction'],
            ['latitude' => 8.9997891, 'longitude' => 7.4724686, 'name' => 'Gudu Market'],
            ['latitude' => 9.0113462, 'longitude' => 7.4741610, 'name' => 'AP Filling Station'],
            ['latitude' => 9.0193643, 'longitude' => 7.4801538, 'name' => 'National Assembly'],
            ['latitude' => 9.0254292, 'longitude' => 7.4875779, 'name' => 'Garki Market Junction'],
            ['latitude' => 9.0294786, 'longitude' => 7.4931000, 'name' => 'Garki International Market'],
            ['latitude' => 9.0321815, 'longitude' => 7.4961507, 'name' => 'Obasanjo Junction'],
            ['latitude' => 9.0374461, 'longitude' => 7.4900439, 'name' => 'Naval HDQTRS Junction Area 10'],
            ['latitude' => 9.0337298, 'longitude' => 7.4859799, 'name' => 'Garki Hospital Junction (Area 8)'],
            ['latitude' => 9.0352599, 'longitude' => 7.4850101, 'name' => 'UTC Junction Area 10'],
            ['latitude' => 9.0379953, 'longitude' => 7.4841972, 'name' => 'Art and Culture Junction'],
            ['latitude' => 9.0428625, 'longitude' => 7.4916070, 'name' => 'Radio House'],
            ['latitude' => 9.0415242, 'longitude' => 7.5024540, 'name' => 'Polaris Bank Gimbiya (Area 11)'],
            ['latitude' => 9.0442212, 'longitude' => 7.5037085, 'name' => 'EFAB Mall Junction'],
            ['latitude' => 9.0488029, 'longitude' => 7.5033370, 'name' => 'RB Dikko Road'],
            ['latitude' => 9.0540510, 'longitude' => 7.4998169, 'name' => 'Ministry of Finance Junction'],
            ['latitude' => 9.0664301, 'longitude' => 7.4967232, 'name' => 'Ministry of Justice Junction'],
            ['latitude' => 9.0777742, 'longitude' => 7.4970712, 'name' => 'Gana Street'],
        ]);
    }
}
