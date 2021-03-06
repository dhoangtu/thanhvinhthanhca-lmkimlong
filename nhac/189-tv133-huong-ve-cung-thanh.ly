% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hướng Về Cung Thánh" }
  composer = "Tv. 133"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 a |
  d, (e) g a |
  a4 \tuplet 3/2 { bf8 g bf } |
  a8. g16 a8 e |
  d4 r8 d |
  d'4. b!16 (a) |
  fs8. g16 a8 (b!) |
  a2 ~ |
  \partial 4. a4 r8 \bar "||"
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 8 a16 a |
  \once \override Score.RehearsalMark.font-size = #0.1
  \mark \markup { \musicglyph #"scripts.segno" }
  a4 \tuplet 3/2 {
    \afterGrace b8 ({
      \override Flag.stroke-style = #"grace"
      a16)}
    \revert Flag.stroke-style
    fs8 a
  }
  b4. e,16 g |
  g4 \tuplet 3/2 { fs8 b a } |
  \partial 4. d,4 r8
  ^\markup { \halign #-2 \fontsize #1 \bold "Tận" }
  \bar "||"
  
  \key f \major
  \partial 8 a'8 |
  bf4 \tuplet 3/2 { g8 a a } |
  e4. f16 e |
  d4 \tuplet 3/2 { e8 g g } |
  a4. a16 d |
  d4. b!16 (a) |
  fs8. g16 a8 (b!) |
  a2 ~ |
  a4 r8 a16 a
  \once \override Score.RehearsalMark.font-size = #0.1
  \mark \markup { \musicglyph #"scripts.segno" }
  \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*7
  r4.
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  fs16 fs |
  fs4 \tuplet 3/2 {
    \afterGrace g8 ({
      \override Flag.stroke-style = #"grace"
      \tweak font-size #-3
      fs16)}
    \revert Flag.stroke-style
    d8 fs
  }
  g4. cs,16 d |
  e4 \tuplet 3/2 { d8 d cs } |
  \partial 4. d4 r8 \bar "||"
  
  \key f \major
  \partial 8 a'8 |
  bf4 \tuplet 3/2 { g8 a a } |
  e4. f16 e |
  d4 \tuplet 3/2 { e8 g g } |
  a4. a16 d |
  d4. b!16 (a) |
  fs8. g16 a8 (b!) |
  a2 ~ |
  a4 r8 f16 f
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  Hỡi tất cả tôi tớ Chúa,
  ứng trực suốt đêm nơi thánh điện Ngài,
  Nào hãy ca tụng danh Chúa đi.
  \set stanza = "ĐK:"
  Giơ tay lên hướng về cung thánh
  mà ca vang lời tán dương Ngài,
  Xin Đấng tác tạo đất trời
  xuống cho bạn ngàn muôn ơn phúc,
  từ núi thánh của Ngài là Si -- on.
  Giơ tay
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
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
% kết thúc mã nguồn

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
    \override Lyrics.LyricSpace.minimum-distance = #1.7
    \override LyricHyphen.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
