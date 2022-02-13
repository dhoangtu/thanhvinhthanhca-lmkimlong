% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vì Chúa Cao Trọng" }
  composer = "Tv. 144"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 f8 |
  a4. g16 (f) |
  d8. c16 g'8 e |
  f4 r8 f16 f |
  e8 f d c |
  a'4. f8 |
  f a16 a bf8 a |
  g4 r8 bf |
  d4. bf8 |
  g8. c16 c8 bf |
  a4 r8 a |
  e d4 c8 |
  
  \pageBreak
  
  g' a4 g8 |
  f2 ~ |
  f4 r8 \bar "||"
  
  f |
  c a'16 a f8 f |
  bf4. bf8 |
  g d'16 d f8 d |
  c4 r8 c |
  f,2 ~ |
  f8 f \slashedGrace { f16 ( } bf8) a |
  g4 g8 g |
  e2 ~ |
  e8 d c g' |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*13
  r4.
  f8 c f16 f ef8 ef |
  d4. g8 |
  e f16 f a8 f |
  e4 r8 e |
  d2 ~ |
  d8 d \slashedGrace { d16 ( } g8) f |
  c4 b!8 b |
  c2 ~ |
  c8 bf bf bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa con thờ, hoàng đế của con,
      Con ca tụng danh Ngài ngàn kiếp,
      Ngày ngày con hoan chúc khôn ngơi,
      Vì Chúa cao trọng rất đáng ca khen,
      Chúa cao trọng thực khôn thấu khôn dò.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Từ trước muôn đời, ngàn kiếp về sau,
	    Muôn dân đề cao sự nghiệp Chúa,
	    truyền tụng huân công Chúa nơi nơi,
	    Quảng bá đây Ngài rất đỗi uy phong,
	    Gẫm suy hoài kỳ công Chúa đã làm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy nói: uy quyền Ngài đáng sợ thay,
	    Bao công việc tay Ngài hoàn tất,
	    Lòng Ngài ôi nhân ái vô song,
	    Ngài rất công bình, cũng rất khoan dung,
	    Rút cơn giận, vì ân nghĩa cao dầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Trìu mến muôn loài Ngài đã dựng nên,
	    Luôn nhân hậu với mọi người thế,
	    Nào người kiên trung hãy ca khen:
	    Lạy Chúa muôn loài cất tiếng tung hô,
	    Nói lên rằng: quyền năng Chúa khôn cùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Người thế nay được nhìn những kỳ công,
	    Vinh quang triều đại Ngài rực rỡ,
	    Triều đại thiên niên vẫn y nguyên,
	    Vạn kiếp uy quyền Chúa vẫn vinh sang,
	    Chúa trung thành và nhân nghĩa muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Lời Chúa ban truyền thực chính trực thay,
	    Bao công việc luôn đầy tình nghĩa,
	    Ngài kề bên ai biết kêu xin,
	    Kẻ kính sợ Ngài mãn ý trông mong,
	    Tiếng họ nài, Ngài mau mắn ưng nhận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Kẻ mến yêu Ngài, Ngài giữ gìn luôn,
	    Nhưng tiêu diệt hết bọn tàn ác,
	    Này miệng tôi vui sướng ca khen,
	    Thể xác muôn loài cất tiếng lên đi,
	    Tán tụng Ngài ngàn muôn kiếp muôn đời.
    }
  >>
  \set stanza = "ĐK:"
  Muôn loài ngước mắt nhìn về Chúa,
  Chính Ngài cứ đúng bữa cho ăn.
  Lúc Ngài rộng mở tay ban,
  bao sinh vật muôn vàn thỏa thuê.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  ragged-bottom = ##t
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
