"use client"
import { motion } from 'framer-motion';
import { useStore } from '@/lib/store';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Upload, Lock, Users, Eye } from 'lucide-react';
import FileGrid from '@/components/files/FileGrid';
import Navbar from '@/components/navbar';
import CircularGallery from '@/components/CircularGallery'

export default function Dashboard() {
   const { files } = useStore();

   const privateFiles = files.filter((f) => f.privacy === 'private');
   const sharedFiles = files.filter((f) => f.privacy === 'shared');
   const publicFiles = files.filter((f) => f.privacy === 'public');


   return (
      <div className="min-h-screen bg-background flex flex-col z-[10]">
         <Navbar />
         <main className="container mx-auto px-4 py-8 flex-1 z-[1]">
            <div className="space-y-8">
               <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="flex flex-col md:flex-row gap-6"
               >
                  <Card className="flex-1">
                     <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                           <Lock className="h-5 w-5" />
                           Private Files
                        </CardTitle>
                     </CardHeader>
                     <CardContent>
                        <div className="text-3xl font-bold">{privateFiles.length}</div>
                     </CardContent>
                  </Card>
                  <Card className="flex-1">
                     <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                           <Users className="h-5 w-5" />
                           Shared Files
                        </CardTitle>
                     </CardHeader>
                     <CardContent>
                        <div className="text-3xl font-bold">{sharedFiles.length}</div>
                     </CardContent>
                  </Card>
                  <Card className="flex-1">
                     <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                           <Eye className="h-5 w-5" />
                           Public Files
                        </CardTitle>
                     </CardHeader>
                     <CardContent>
                        <div className="text-3xl font-bold">{publicFiles.length}</div>
                     </CardContent>
                  </Card>
               </motion.div>

               <div className="flex justify-between items-center">
                  <h2 className="text-3xl font-bold">Your Files</h2>
                  <Button asChild>
                     <a href="/upload">
                        <Upload className="mr-2 h-5 w-5" /> Upload Files
                     </a>
                  </Button>
               </div>

               <Tabs defaultValue="all" className="w-full">
                  <TabsList>
                     <TabsTrigger value="all">All Files</TabsTrigger>
                     <TabsTrigger value="private">Private</TabsTrigger>
                     <TabsTrigger value="shared">Shared</TabsTrigger>
                     <TabsTrigger value="public">Public</TabsTrigger>
                  </TabsList>
                  <TabsContent value="all">
                     <FileGrid files={files} />
                  </TabsContent>
                  <TabsContent value="private">
                     <FileGrid files={privateFiles} />
                  </TabsContent>
                  <TabsContent value="shared">
                     <FileGrid files={sharedFiles} />
                  </TabsContent>
                  <TabsContent value="public">
                     <FileGrid files={publicFiles} />
                  </TabsContent>
               </Tabs>
            </div>
            <div style={{ height: '600px', position: 'relative' }} className='w-full flex justify-center'>
               <CircularGallery bend={3} textColor="#ffffff" borderRadius={0.05} />
            </div>

         </main>
      </div>
   );
}